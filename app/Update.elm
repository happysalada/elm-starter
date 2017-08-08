module Update exposing (..)

import Models exposing (Model, Message(..), Route(..))
import UrlParser exposing (..)
import Navigation exposing (Location)
import Element exposing (classifyDevice)


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Resize size ->
            { model | device = classifyDevice size } ! []

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
