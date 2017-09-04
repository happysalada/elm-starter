module Update exposing (..)

import Http
import Task
import Models exposing (Model, Message(..), Route(..), OcrStatus(..))
import UrlParser exposing (parseHash, Parser, oneOf, map, top, s)
import Navigation exposing (Location)
import Element exposing (classifyDevice)
import RemoteData
import Json.Decode exposing (Decoder, int, string, list)
import Json.Decode.Pipeline exposing (decode, required, optional)
import FileReader exposing (NativeFile, readAsDataUrl)


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Resize windowSize ->
            { model | device = classifyDevice windowSize } ! []

        DragEnter ->
            { model | dragAndDrop = model.dragAndDrop + 1, ocrStatus = UploadFileAction } ! []

        DragLeave ->
            { model | dragAndDrop = model.dragAndDrop - 1 } ! []

        Drop nativeFiles ->
            { model | dragAndDrop = 0, nativeFiles = nativeFiles, ocrStatus = FileUploaded } ! []

        FileData (Ok val) ->
            let
                imageBase64String =
                    toString val
                        |> String.split "base64,"
                        |> List.reverse
                        |> List.head
                        |> Maybe.withDefault ""
                        |> (++) "\""
            in
                { model | ocrStatus = SendingFile, imageData = imageBase64String } ! [ sendFiletoCloudVision imageBase64String ]

        FileData (Err err) ->
            { model | ocrError = Just (toString err) } ! []

        ParseImageFile ->
            { model | ocrStatus = ParsingFile } ! [ parseFileToBase64 model.nativeFiles ]

        ReceiveOcrResults ocrResults ->
            { model | ocrStatus = ResponseReceived, ocrResponse = ocrResults } ! []

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                { model | route = newRoute } ! []

        GoToAboutPage ->
            ( model, Navigation.newUrl "#about" )

        GoToMainPage ->
            ( model, Navigation.newUrl "/" )

        NoOp ->
            model ! []


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map MainPage top
        , map AboutPage (s "about")
        ]


parseFileToBase64 : List NativeFile -> Cmd Message
parseFileToBase64 nativeFiles =
    case nativeFiles of
        nativefile :: _ ->
            .blob nativefile
                |> readAsDataUrl
                |> Task.map Ok
                |> Task.onError (Task.succeed << Err)
                |> Task.perform FileData

        [] ->
            Cmd.none


sendFiletoCloudVision : String -> Cmd Message
sendFiletoCloudVision imagebase64String =
    let
        request =
            Http.request
                { method = "POST"
                , headers = []
                , url = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyB1edq04MbFWy3loHw4_1BJUHnAYZd7sSg"
                , body = Http.stringBody "application/json" (ocrRequestBody imagebase64String)
                , expect = Http.expectJson ocrResponseDecoder
                , timeout = Nothing
                , withCredentials = False
                }
    in
        request
            |> RemoteData.sendRequest
            |> Cmd.map ReceiveOcrResults


ocrResponseDecoder : Decoder (List (List String))
ocrResponseDecoder =
    decode identity
        |> required "responses" (list ocrTextAnnotationDecoder)


ocrTextAnnotationDecoder : Decoder (List String)
ocrTextAnnotationDecoder =
    decode identity
        |> required "textAnnotations" (list ocrDescriptionDecoder)


ocrDescriptionDecoder : Decoder String
ocrDescriptionDecoder =
    decode identity
        |> required "description" string


ocrRequestBody : String -> String
ocrRequestBody imagebase64String =
    """{"requests": [{"image": {"content":"""
        ++ imagebase64String
        ++ """},"features": [{"type": "TEXT_DETECTION"}]}]}"""
