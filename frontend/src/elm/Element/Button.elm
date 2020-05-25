module Element.Button exposing
    ( Button
    , primary
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale


type Button msg
    = Button (Button_ msg)


type alias Button_ msg =
    { fill : Fill
    , text : String
    , icon : Maybe Icon
    , onClick : msg
    }


type Icon
    = Heart


type Fill
    = Solid
    | Hollow


primary : msg -> String -> Element msg
primary msg text =
    toElement
        (Button
            { fill = Solid
            , text = text
            , icon = Nothing
            , onClick = msg
            }
        )


toElement : Button msg -> Element msg
toElement (Button button_) =
    Input.button
        [ toFill button_
        , Border.color Palette.green
        , Border.width 2
        , Border.rounded 5
        , paddingXY Scale.large Scale.medium
        , Font.letterSpacing 1
        ]
        { onPress = Just button_.onClick
        , label = toLabel button_
        }


toFill button_ =
    case button_.fill of
        Solid ->
            Background.color Palette.green

        Hollow ->
            Background.color Palette.white


toLabel button_ =
    case button_.fill of
        Solid ->
            el [ Font.color Palette.white ] (text button_.text)

        Hollow ->
            el [ Font.color Palette.green ] (text button_.text)
