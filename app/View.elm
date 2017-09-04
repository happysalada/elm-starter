module View exposing (view)

import Html exposing (Html, div, h1)
import Html.Attributes exposing (class, style, id, attribute, type_, multiple)
import Html.Events exposing (on)
import Models exposing (Model, Message(..), OcrStatus(..))
import Color
import Element exposing (root, text, html, column, nav, row, el, header, section, Element, button, link)
import Element.Attributes exposing (verticalCenter, height, width, fill, px, spacing, center, justify, padding, paddingXY, percent, clip, maxHeight, maxWidth, inlineStyle, spacingXY, target)
import Element.Events exposing (onWithOptions, onClick)
import Style exposing (style, StyleSheet, paddingHint, hover)
import Style.Color as Color
import Style.Shadow as Shadow
import Style.Border as Border
import Style.Transition as Transition exposing (all)
import Style.Font as Font exposing (typeface, lineHeight, size)
import Json.Decode as Json
import FileReader exposing (parseDroppedFiles, parseSelectedFiles)
import RemoteData


type Styles
    = None
    | MainPage
    | Nav
    | Logo
    | Hero
    | Title
    | Subtitle
    | ActionButton


mainColors =
    { indigo = Color.rgba 63 81 181 1
    , darkIndigo = Color.rgba 0 41 132 1
    , pink = Color.rgba 233 30 99 1
    , lightGrey = Color.rgba 245 245 245 1
    }


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ Style.style None []
        , Style.style MainPage
            [ Color.text Color.darkCharcoal
            , Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Font.size 16
            , Font.lineHeight 1.3
            ]
        , Style.style Nav
            [ paddingHint 12
            , Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.darkIndigo
            ]
        , Style.style Logo
            [ Font.size 20
            , Color.text Color.white
            ]
        , Style.style Hero
            [ Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.indigo
            , Color.text Color.white
            , Font.center
            ]
        , Style.style Title
            [ Font.size 42
            ]
        , Style.style Subtitle
            []
        , Style.style ActionButton
            [ Transition.all
            , Color.background mainColors.pink
            , Color.text Color.white
            , Shadow.glow Color.charcoal 2
            , Border.rounded 2
            , paddingHint 16
            , hover
                [ Style.cursor "pointer"
                , Shadow.simple
                ]
            ]
        ]


view : Model -> Html Message
view model =
    case model.route of
        Models.MainPage ->
            mainPage model

        Models.AboutPage ->
            aboutPage

        Models.NotFoundRoute ->
            notFoundView


mainPage : Model -> Html Message
mainPage model =
    Element.viewport stylesheet <|
        column MainPage
            []
            [ nav <|
                row Nav
                    []
                    [ el Logo [] (text "簡単にOCR") ]
            , header <|
                column Hero
                    [ center, verticalCenter, height (px (toFloat model.device.height * 0.4)), spacingXY 0 16 ]
                    [ el Title [] (text "簡単に画像にOCRをする")
                    , el Subtitle [] (text "以下に画像をアップロードしてまたはドラッグ&ドロップしてから自動的にOCRしてくれます")
                    ]
            , section <|
                column None
                    (List.append
                        [ verticalCenter
                        , center
                        , height (px (toFloat model.device.height * 0.4))
                        ]
                        dragAndDropEventHandlers
                    )
                    (case model.ocrStatus of
                        NoFileUploaded ->
                            [ text "画像をアップロードしてまたはドラッグ&ドロップ"
                            , html
                                (Html.input
                                    [ type_ "file"
                                    , multiple True
                                    , Html.Events.on "change" (Json.map Drop parseSelectedFiles)
                                    ]
                                    []
                                )
                            ]

                        UploadFileAction ->
                            [ text "ここにドロップ" ]

                        FileUploaded ->
                            [ el ActionButton
                                [ onClick ParseImageFile ]
                                (model.nativeFiles
                                    |> List.map .name
                                    |> List.foldr (++) "にOCRを行う"
                                    |> text
                                )
                            ]

                        ParsingFile ->
                            [ text "画像処理中" ]

                        SendingFile ->
                            [ text "処理されたデータにOCRを行い中" ]

                        ResponseReceived ->
                            showResponse model
                    )
            ]


dragAndDropEventHandlers : List (Element.Attribute variation Message)
dragAndDropEventHandlers =
    [ onWithOptions "dragenter" { stopPropagation = False, preventDefault = True } (Json.succeed DragEnter)
    , onWithOptions "dragover" { stopPropagation = False, preventDefault = True } (Json.succeed NoOp)
    , onWithOptions "dragleave" { stopPropagation = False, preventDefault = True } (Json.succeed DragLeave)
    , onWithOptions "drop" { stopPropagation = True, preventDefault = True } (Json.map Drop parseDroppedFiles)
    ]


showResponse : Model -> List (Element Styles variation msg)
showResponse model =
    case model.ocrResponse of
        RemoteData.NotAsked ->
            [ text "画像処理に問題が発生しました" ]

        RemoteData.Loading ->
            [ text "ローディング" ]

        RemoteData.Success response ->
            case response of
                (textAnnotation :: _) :: _ ->
                    [ el None [] (text "いただいたデータは")
                    , el None [] (text textAnnotation)
                    ]

                _ ->
                    [ text ("画像処理に問題が発生しました" ++ toString response) ]

        RemoteData.Failure error ->
            [ text ("この問題が発生しました" ++ toString error) ]


aboutPage : Html msg
aboutPage =
    div [ Html.Attributes.class "jumbotron" ]
        [ div [ Html.Attributes.class "container" ]
            [ h1 [] [ Html.text "This is <about> page" ]
            , Html.button [ Html.Attributes.class "btn btn-primary btn-lg" ] [ Html.text "Go To Main Page" ]
            ]
        ]


notFoundView : Html msg
notFoundView =
    div []
        [ Html.text "Not found"
        ]
