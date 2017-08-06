module Models exposing (..)

import Navigation exposing (Location)


type Message
    = OnLocationChange Location
    | GoToAboutPage
    | GoToMainPage
    | NoOp


initialModel : Route -> Model
initialModel route =
    { route = route
    }


type alias Model =
    { route : Route
    }


type Route
    = MainPage
    | AboutPage
    | NotFoundRoute
