module Models exposing (..)


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
