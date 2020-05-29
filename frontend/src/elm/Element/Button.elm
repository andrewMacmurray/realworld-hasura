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
        , Transition.all
        , toBorderColor button_
        , toFontColor button_
        , Border.width 1
        , Border.rounded 5
        , toPadding button_
        , mouseOver (toHoverStyles button_)
        ]
        { onPress = Just button_.onClick
        , label = label button_
        }


toPadding : Button_ msg -> Attribute msg
toPadding _ =
    paddingXY Scale.medium Scale.small


toHoverStyles button_ =
    case button_.fill of
        Solid ->
            [ Background.color (toDarker button_.color)
            , Border.color (toDarker button_.color)
            ]

        Hollow ->
            [ Background.color (toColor button_.color)
            , Font.color Palette.white
            ]


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


toFontColor button_ =
    case button_.fill of
        Solid ->
            Font.color Palette.white

        Hollow ->
            Font.color (toColor button_.color)


toColor : Color -> Element.Color
toColor color =
    case color of
        Green ->
            Palette.green

        Red ->
            Palette.red


toDarker color =
    case color of
        Green ->
            Palette.deepGreen

        Red ->
            Palette.darkRed


label : Button_ msg -> Element msg
label button_ =
    el [ toFontSize button_ ] (text button_.text)


toFontSize button_ =
    case button_.size of
        Large ->
            Font.size (Text.medium - 2)

        Medium ->
            Font.size Text.small
