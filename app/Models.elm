module Models exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)


type Message
    = OnLocationChange Location
    | GoToAboutPage
    | GoToMainPage
    | Resize Size
    | NoOp


initialModel : Route -> Model
initialModel route =
    { route = route
    , device = initialDevice
    }


initialDevice : Device
initialDevice =
    { width = 1024
    , height = 768
    , phone = False
    , tablet = False
    , desktop = True
    , bigDesktop = False
    , portrait = False
    }


type alias Model =
    { route : Route
    , device : Device
    }


type alias Device =
    { width : Int
    , height : Int
    , phone : Bool
    , tablet : Bool
    , desktop : Bool
    , bigDesktop : Bool
    , portrait : Bool
    }


type Route
    = MainPage
    | AboutPage
    | NotFoundRoute
