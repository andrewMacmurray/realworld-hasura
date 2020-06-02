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
import Element.Transition as Transition


type Button msg
    = Button (Options msg)


type alias Options msg =
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
toElement (Button options) =
    Input.button
        [ fill options
        , Transition.colors
        , borderColor options
        , fontColor options
        , Border.width 1
        , Border.rounded 5
        , paddingXY Scale.medium Scale.small
        , mouseOver (toHoverStyles options)
        ]
        { onPress = Just options.onClick
        , label = label options
        }


toHoverStyles : Options msg -> List Decoration
toHoverStyles options =
    case options.fill of
        Solid ->
            [ Background.color (toDarker options.color)
            , Border.color (toDarker options.color)
            ]

        Hollow ->
            [ Background.color (toColor options.color)
            , Font.color Palette.white
            ]


fill : Options msg -> Attr decorative msg
fill options =
    case ( options.fill, options.color ) of
        ( Solid, color ) ->
            Background.color (toColor color)

        ( Hollow, _ ) ->
            Background.color Palette.white


borderColor : Options msg -> Attr decorative msg
borderColor options =
    Border.color (toColor options.color)


fontColor : Options msg -> Attr decorative msg
fontColor options =
    case options.fill of
        Solid ->
            Font.color Palette.white

        Hollow ->
            Font.color (toColor options.color)


toColor : Color -> Element.Color
toColor color =
    case color of
        Green ->
            Palette.green

        Red ->
            Palette.red


toDarker : Color -> Element.Color
toDarker color =
    case color of
        Green ->
            Palette.deepGreen

        Red ->
            Palette.darkRed


label : Options msg -> Element msg
label options =
    el [ toFontSize options ] (text options.text)


toFontSize : Options msg -> Attr decorative msg
toFontSize options =
    case options.size of
        Large ->
            Font.size (Text.medium - 2)

        Medium ->
            Font.size Text.small
