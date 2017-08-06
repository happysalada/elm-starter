module Update exposing (..)

import Models exposing (Model)
import Navigation
import Messages exposing (Message(..))
import Routing exposing (parseLocation)
import Dom
import Task


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
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
