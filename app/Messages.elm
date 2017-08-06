module Messages exposing (Message(..))

import Models exposing (..)
import Navigation exposing (Location)


type Message
    = OnLocationChange Location
    | GoToAboutPage
    | GoToMainPage
    | NoOp
