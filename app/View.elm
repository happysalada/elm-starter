module View exposing (view)

import Html exposing (Html, button, div, h1, span, text)
import Html.Attributes exposing (class, style, id, attribute)
import Html.Events exposing (keyCode)
import Models exposing (Model)
import Messages exposing (Message(..))
import Update
import RemoteData exposing (WebData)
import Json.Decode as Json
import Color
import Element exposing (root, text, html, column, nav, row, el, header, section, Element)
import Element.Attributes exposing (verticalCenter, height, width, fill, px, spacing, center, justify, padding, paddingXY, percent, clip, maxHeight, maxWidth, inlineStyle)
import Style exposing (style, StyleSheet, paddingHint, hover)
import Style.Border as Border
import Style.Shadow as Shadow
import Style.Color as Color
import Style.Font as Font exposing (typeface, lineHeight, size)
import Style.Transition as Transition exposing (all)


type Styles
    = None
    | MainPage
    | Nav
    | Logo
    | Hero
    | Title
    | Subtitle


mainColors =
    { indigo = Color.rgba 63 81 181 1
    , darkIndigo = Color.rgba 0 41 132 1
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
            [ paddingHint 10
            , Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.darkIndigo
            ]
        , Style.style Logo
            [ Font.size 20
            , Color.text Color.white
            ]
        , Style.style Hero
            [ Font.center
            , Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.indigo
            , Color.text Color.white
            ]
        , Style.style Title
            [ Font.size 40
            ]
        , Style.style Subtitle
            []
        ]


view : Model -> Html Message
view model =
    div []
        [ page model ]


page : Model -> Html Message
page model =
    case model.route of
        Models.MainPage ->
            mainPage model

        Models.AboutPage ->
            aboutPage

        Models.NotFoundRoute ->
            notFoundView


mainPage : Model -> Html Message
mainPage model =
    Element.root stylesheet <|
        column MainPage
            []
            [ nav <|
                row Nav
                    []
                    [ el Logo [] (Element.text "Git Back") ]
            , header <|
                column Hero
                    [ verticalCenter, height (px 200), spacing 16 ]
                    [ el Title [] (Element.text "Contribute to open source")
                    , el Subtitle [] (Element.text "Help out on unassigned open issues")
                    ]
            , section <|
                column None
                    [ center, width (fill 1) ]
                    [ el None
                        [ padding 16 ]
                        (Element.text "Starter")
                    ]
            ]


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
