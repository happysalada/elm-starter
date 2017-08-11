module View exposing (view)

import Html exposing (Html, div, h1)
import Html.Attributes exposing (class, style, id, attribute)
import Models exposing (Model, Message(..))
import Color
import Element exposing (root, text, html, column, nav, row, el, header, section, Element, button, link)
import Element.Attributes exposing (verticalCenter, height, width, fill, px, spacing, center, justify, padding, paddingXY, percent, clip, maxHeight, maxWidth, inlineStyle, spacingXY, target)
import Style exposing (style, StyleSheet, paddingHint, hover)
import Style.Color as Color
import Style.Shadow as Shadow
import Style.Border as Border
import Style.Transition as Transition exposing (all)
import Style.Font as Font exposing (typeface, lineHeight, size)


type Styles
    = None
    | MainPage
    | Nav
    | Logo
    | Hero
    | Title
    | Subtitle
    | ActionButton


mainColors =
    { indigo = Color.rgba 63 81 181 1
    , darkIndigo = Color.rgba 0 41 132 1
    , pink = Color.rgba 233 30 99 1
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
            [ paddingHint 12
            , Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.darkIndigo
            ]
        , Style.style Logo
            [ Font.size 20
            , Color.text Color.white
            ]
        , Style.style Hero
            [ Font.typeface [ "helvetica", "arial", "sans-serif" ]
            , Color.background mainColors.indigo
            , Color.text Color.white
            , Font.center
            ]
        , Style.style Title
            [ Font.size 42
            ]
        , Style.style Subtitle
            []
        , Style.style ActionButton
            [ Transition.all
            , Color.background mainColors.pink
            , Color.text Color.white
            , Shadow.glow Color.charcoal 2
            , Border.rounded 2
            , paddingHint 16
            , hover
                [ Style.cursor "pointer"
                , Shadow.simple
                ]
            ]
        ]


view : Model -> Html Message
view model =
    case model.route of
        Models.MainPage ->
            mainPage model

        Models.AboutPage ->
            aboutPage

        Models.NotFoundRoute ->
            notFoundView


mainPage : Model -> Html Message
mainPage model =
    Element.viewport stylesheet <|
        column MainPage
            []
            [ nav <|
                row Nav
                    []
                    [ el Logo [] (text "Elm Starter") ]
            , header <|
                column Hero
                    [ verticalCenter, height (px (toFloat model.device.height * 0.4)), spacingXY 0 16 ]
                    [ el Title [] (text "Quick start with Elm")
                    , el Subtitle [] (text "service workers, google analytics, style elements, firebase functions, and more!")
                    ]
            , section <|
                column None
                    [ verticalCenter, center, height (px (toFloat model.device.height * 0.4)) ]
                    [ link "https://github.com/happysalada/elm-starter" <|
                        el ActionButton [ target "_blank" ] (text (String.toUpper "Look at the code"))
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
