module App exposing (main)

import Routing
import Messages exposing (Message(..))
import Navigation exposing (Location)
import Models exposing (..)
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Message )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        initModel =
            initialModel currentRoute
    in
        initModel ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Message
main =
    Navigation.program Messages.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
