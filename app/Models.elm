module Models exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)
import FileReader exposing (NativeFile, Error, FileContentDataUrl)
import RemoteData


type alias Model =
    { route : Route
    , device : Device
    , ocrStatus : OcrStatus
    , dragAndDrop : Int
    , nativeFiles : List NativeFile
    , imageData : String
    , ocrError : Maybe String
    , ocrResponse : RemoteData.WebData (List (List String))
    }


type Route
    = MainPage
    | AboutPage
    | NotFoundRoute


type OcrStatus
    = NoFileUploaded
    | UploadFileAction
    | FileUploaded
    | ParsingFile
    | SendingFile
    | ResponseReceived


type alias Device =
    { width : Int
    , height : Int
    , phone : Bool
    , tablet : Bool
    , desktop : Bool
    , bigDesktop : Bool
    , portrait : Bool
    }


type Message
    = OnLocationChange Location
    | GoToAboutPage
    | GoToMainPage
    | Resize Size
    | DragEnter
    | DragLeave
    | Drop (List NativeFile)
    | ParseImageFile
    | FileData (Result Error FileContentDataUrl)
    | ReceiveOcrResults (RemoteData.WebData (List (List String)))
    | NoOp


initialModel : Route -> Model
initialModel route =
    { route = route
    , device = initialDevice
    , ocrStatus = NoFileUploaded
    , dragAndDrop = 0
    , nativeFiles = []
    , imageData = ""
    , ocrError = Nothing
    , ocrResponse = RemoteData.NotAsked
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
