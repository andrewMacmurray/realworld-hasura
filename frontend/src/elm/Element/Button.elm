module Element.Button exposing
    ( Button
    , button
    , decorative
    , description
    , follow
    , like
    , primary
    , secondary
    , solid
    , toElement
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Icon as Icon
import Element.Icon.Heart as Heart
import Element.Icon.Plus as Plus
import Element.Input as Input
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Element.Transition as Transition



-- Button


type Button msg
    = Button (Options msg)


type alias Options msg =
    { fill : Fill
    , text : String
    , size : Size
    , shape : Shape
    , color : Color
    , icon : Maybe Icon
    , onClick : Maybe msg
    , description : Maybe String
    , hover : Bool
    }


type Shape
    = Square
    | Pill


type Size
    = Large
    | Medium
    | Small


type Fill
    = Solid
    | Hollow
    | Borderless


type Color
    = Green
    | Red
    | Grey


type Icon
    = Heart
    | Plus



-- Defaults


defaults : Maybe msg -> String -> Button msg
defaults msg text =
    Button
        { fill = Solid
        , color = Green
        , size = Medium
        , icon = Nothing
        , shape = Square
        , text = text
        , onClick = msg
        , description = Nothing
        , hover = True
        }



-- Construct


decorative : String -> Button msg
decorative text =
    defaults Nothing text |> noHover


button : msg -> String -> Button msg
button msg text =
    defaults (Just msg) text



-- Configure


primary : Button msg -> Button msg
primary =
    identity


secondary : Button msg -> Button msg
secondary =
    red >> hollow


like : Button msg -> Button msg
like =
    borderless >> heart >> small >> pill


follow : Button msg -> Button msg
follow =
    borderless >> plus >> grey >> small


red : Button msg -> Button msg
red (Button options) =
    Button { options | color = Red }


plus : Button msg -> Button msg
plus (Button options) =
    Button { options | icon = Just Plus }


grey : Button msg -> Button msg
grey (Button options) =
    Button { options | color = Grey }


small : Button msg -> Button msg
small (Button options) =
    Button { options | size = Small }


pill : Button msg -> Button msg
pill (Button options) =
    Button { options | shape = Pill }


description : String -> Button msg -> Button msg
description d (Button options) =
    Button { options | description = Just d }


borderless : Button msg -> Button msg
borderless (Button options) =
    Button { options | fill = Borderless }


hollow : Button msg -> Button msg
hollow (Button options) =
    Button { options | fill = Hollow }


solid : Button msg -> Button msg
solid (Button options) =
    Button { options | fill = Solid }


heart : Button msg -> Button msg
heart (Button options) =
    Button { options | icon = Just Heart }


noHover : Button msg -> Button msg
noHover (Button options) =
    Button { options | hover = False }



-- Render


toElement : Button msg -> Element msg
toElement (Button options) =
    Input.button
        (List.concat
            [ [ fill_ options
              , Transition.colors
              , borderColor options
              , fontColor options
              , Border.width 1
              , borderRadius_ options
              , padding_ options
              , mouseOver (hoverStyles options)
              ]
            , description_ options
            , iconHover options
            ]
        )
        { onPress = options.onClick
        , label = label options
        }


description_ : Options msg -> List (Attribute msg)
description_ options =
    options.description
        |> Maybe.map (Anchor.description >> List.singleton)
        |> Maybe.withDefault []


borderRadius_ : Options msg -> Attribute msg
borderRadius_ options =
    case options.shape of
        Square ->
            Border.rounded 5

        Pill ->
            Border.rounded 100


padding_ : Options msg -> Attribute msg
padding_ options =
    case options.size of
        Large ->
            paddingXY Scale.medium Scale.small

        Medium ->
            paddingXY Scale.medium Scale.small

        Small ->
            paddingXY (Scale.small - 2) Scale.extraSmall


hoverStyles : Options msg -> List Decoration
hoverStyles options =
    case ( options.hover, options.fill ) of
        ( False, _ ) ->
            []

        ( _, Solid ) ->
            [ Background.color (darkerColor options.color)
            , Border.color (darkerColor options.color)
            ]

        ( _, Hollow ) ->
            [ Background.color (color options.color)
            , Font.color Palette.white
            ]

        ( _, Borderless ) ->
            [ Background.color (color options.color)
            , Font.color Palette.white
            ]


fill_ : Options msg -> Attr decorative msg
fill_ options =
    case ( options.fill, options.color ) of
        ( Solid, color_ ) ->
            Background.color (color color_)

        ( Hollow, _ ) ->
            Background.color Palette.transparent

        ( Borderless, _ ) ->
            Background.color Palette.transparent


borderColor : Options msg -> Attr decorative msg
borderColor options =
    case options.fill of
        Borderless ->
            Border.color Palette.transparent

        _ ->
            Border.color (color options.color)


fontColor : Options msg -> Attr decorative msg
fontColor options =
    case options.fill of
        Solid ->
            Font.color Palette.white

        Hollow ->
            Font.color (color options.color)

        Borderless ->
            Font.color (color options.color)


color : Color -> Element.Color
color color_ =
    case color_ of
        Green ->
            Palette.green

        Red ->
            Palette.red

        Grey ->
            Palette.grey


darkerColor : Color -> Element.Color
darkerColor color_ =
    case color_ of
        Green ->
            Palette.deepGreen

        Red ->
            Palette.darkRed

        Grey ->
            Palette.black


label : Options msg -> Element msg
label options =
    case options.icon of
        Just icon_ ->
            row [ width fill, spacing Scale.extraSmall ]
                [ el [ centerY ] (icon icon_ options)
                , el [ centerY ] (text_ options)
                ]

        Nothing ->
            text_ options


iconHover : Options msg -> List (Attribute msg)
iconHover options =
    case ( options.icon, options.hover ) of
        ( Just _, True ) ->
            [ Icon.enableHover ]

        ( _, _ ) ->
            []


icon : Icon -> Options msg -> Element msg
icon icon_ options =
    case icon_ of
        Heart ->
            Heart.icon (iconColor options)

        Plus ->
            Plus.icon (iconColor options)


iconColor : Options msg -> Element.Color
iconColor options =
    case ( options.color, options.fill ) of
        ( _, Solid ) ->
            Palette.white

        ( Green, _ ) ->
            Palette.green

        ( Red, _ ) ->
            Palette.red

        ( Grey, _ ) ->
            Palette.grey


text_ : Options msg -> Element msg
text_ options =
    el [ toFontSize options ] (text options.text)


toFontSize : Options msg -> Attr decorative msg
toFontSize options =
    case options.size of
        Large ->
            Font.size (Text.medium - 2)

        Medium ->
            Font.size Text.small

        Small ->
            Font.size Text.small
