module Element.Button exposing
    ( Button
    , primary
    , secondary
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text


type Button msg
    = Button (Button_ msg)


type alias Button_ msg =
    { fill : Fill
    , text : String
    , size : Size
    , color : Color
    , onClick : msg
    }


type Size
    = Large
    | Medium


type Fill
    = Solid
    | Hollow


type Color
    = Green
    | Red


secondary : msg -> String -> Element msg
secondary msg text =
    toElement
        (Button
            { fill = Hollow
            , color = Red
            , size = Medium
            , text = text
            , onClick = msg
            }
        )


primary : msg -> String -> Element msg
primary msg text =
    toElement
        (Button
            { fill = Solid
            , color = Green
            , size = Large
            , text = text
            , onClick = msg
            }
        )


toElement : Button msg -> Element msg
toElement (Button button_) =
    Input.button
        [ toFill button_
        , toBorderColor button_
        , Border.width 1
        , Border.rounded 5
        , toPadding button_
        , Font.letterSpacing 1
        ]
        { onPress = Just button_.onClick
        , label = toLabel button_
        }


toPadding : Button_ msg -> Attribute msg
toPadding button_ =
    case button_.size of
        Large ->
            paddingXY Scale.large Scale.medium

        Medium ->
            paddingXY Scale.medium Scale.small


toFill : Button_ msg -> Attr decorative msg
toFill button_ =
    case ( button_.fill, button_.color ) of
        ( Solid, color ) ->
            Background.color (toColor color)

        ( Hollow, _ ) ->
            Background.color Palette.white


toBorderColor : Button_ msg -> Attr decorative msg
toBorderColor button_ =
    Border.color (toColor button_.color)


toColor : Color -> Element.Color
toColor color =
    case color of
        Green ->
            Palette.green

        Red ->
            Palette.darkRed


toLabel : Button_ msg -> Element msg
toLabel button_ =
    case button_.fill of
        Solid ->
            el (toLabelAttributes button_ ++ [ Font.color Palette.white ])
                (text button_.text)

        Hollow ->
            el
                (toLabelAttributes button_ ++ [ Font.color (toColor button_.color) ])
                (text button_.text)


toLabelAttributes button_ =
    case button_.size of
        Large ->
            [ Font.regular
            , Font.size Text.medium
            ]

        Medium ->
            [ Font.size Text.small
            , Font.letterSpacing 0
            ]
