module App exposing (main)

import Navigation exposing (Location)
import Models exposing (initialModel, Model, Message(..))
import Update exposing (update)
import View exposing (view)
import Window exposing (resizes)
import Task


init : Location -> ( Model, Cmd Message )
init location =
    let
        currentRoute =
            Update.parseLocation location

        initModel =
            initialModel currentRoute
    in
        initModel ! [ Task.perform Resize Window.size ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Window.resizes (\size -> Resize size)



-- MAIN


main : Program Never Model Message
main =
    Navigation.program Models.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
