module Element.Button exposing
    ( Button
    , button
    , decorative
    , delete
    , description
    , disabled
    , edit
    , ellipsis
    , follow
    , light
    , like
    , link
    , loadMore
    , noText
    , post
    , primary
    , solid
    , toElement
    , unfollow
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Icon as Icon
import Element.Icon.Bin as Bin
import Element.Icon.Chevron as Chevron
import Element.Icon.Ellipsis as Elipsis
import Element.Icon.Heart as Heart
import Element.Icon.Pencil as Pencil
import Element.Icon.Plane as Plane
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
    , text : Maybe String
    , size : Size
    , shape : Shape
    , color : Color
    , icon : Maybe Icon
    , description : Maybe String
    , hover : Bool
    , onClick : Action msg
    , shade : Shade
    }


type Action msg
    = Msg msg
    | Link String
    | None


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
    | NoFill


type Color
    = Green
    | Red
    | Grey


type Icon
    = Heart
    | Plus
    | Cross
    | Plane
    | Pencil
    | Bin
    | Ellipsis
    | Chevron


type Shade
    = Light
    | Dark



-- Defaults


defaults : Action msg -> String -> Button msg
defaults action text =
    Button
        { fill = Solid
        , color = Green
        , size = Medium
        , icon = Nothing
        , shape = Square
        , text = Just text
        , onClick = action
        , description = Nothing
        , hover = True
        , shade = Dark
        }



-- Construct


decorative : String -> Button msg
decorative =
    defaults None >> noHover


button : msg -> String -> Button msg
button msg =
    defaults (Msg msg)


link : { href : String, text : String } -> Button msg
link { href, text } =
    defaults (Link href) text


disabled : String -> Button msg
disabled =
    decorative >> grey >> hollow



-- Configure


primary : Button msg -> Button msg
primary =
    identity


ellipsis : Button msg -> Button msg
ellipsis =
    borderless
        >> noBackground
        >> withIcon_ Ellipsis
        >> noText
        >> small
        >> grey


edit : Button msg -> Button msg
edit =
    borderless
        >> withIcon_ Pencil
        >> small
        >> grey


post : Button msg -> Button msg
post =
    small
        >> withIcon_ Plane
        >> borderless


like : Button msg -> Button msg
like =
    borderless
        >> withIcon_ Heart
        >> small
        >> pill


follow : Button msg -> Button msg
follow =
    borderless
        >> withIcon_ Plus
        >> grey
        >> small


unfollow : Button msg -> Button msg
unfollow =
    follow >> withIcon_ Cross


delete : Button msg -> Button msg
delete =
    borderless
        >> withIcon_ Bin
        >> small
        >> red


loadMore : Button msg -> Button msg
loadMore =
    pill >> hollow >> withIcon_ Chevron


light : Button msg -> Button msg
light (Button options) =
    Button { options | shade = Light }


red : Button msg -> Button msg
red (Button options) =
    Button { options | color = Red }


grey : Button msg -> Button msg
grey (Button options) =
    Button { options | color = Grey }


small : Button msg -> Button msg
small (Button options) =
    Button { options | size = Small }


noBackground : Button msg -> Button msg
noBackground (Button options) =
    Button { options | fill = NoFill }


pill : Button msg -> Button msg
pill (Button options) =
    Button { options | shape = Pill }


description : String -> Button msg -> Button msg
description d (Button options) =
    Button { options | description = Just d }


borderless : Button msg -> Button msg
borderless (Button options) =
    Button { options | fill = Borderless }


noText : Button msg -> Button msg
noText (Button options) =
    Button { options | text = Nothing }


hollow : Button msg -> Button msg
hollow =
    withFill_ Hollow


solid : Button msg -> Button msg
solid =
    withFill_ Solid


noHover : Button msg -> Button msg
noHover (Button options) =
    Button { options | hover = False }


withFill_ : Fill -> Button msg -> Button msg
withFill_ fill (Button options) =
    Button { options | fill = fill }


withIcon_ : Icon -> Button msg -> Button msg
withIcon_ icon_ (Button options) =
    Button { options | icon = Just icon_ }



-- Render


toElement : Button msg -> Element msg
toElement (Button options) =
    case options.onClick of
        Msg msg ->
            toButton (Just msg) options

        Link href ->
            toLink href options

        None ->
            toButton Nothing options


toLink : String -> Options msg -> Element msg
toLink href options =
    Element.link (toAttributes options)
        { url = href
        , label = label options
        }


toButton : Maybe msg -> Options msg -> Element msg
toButton onPress options =
    Input.button (toAttributes options)
        { onPress = onPress
        , label = label options
        }


toAttributes : Options msg -> List (Attribute msg)
toAttributes options =
    List.concat
        [ [ fill_ options
          , transition_ options
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


description_ : Options msg -> List (Attribute msg)
description_ options =
    options.description
        |> Maybe.map (Anchor.description >> List.singleton)
        |> Maybe.withDefault []


transition_ : Options msg -> Attribute msg
transition_ options =
    case options.fill of
        Borderless ->
            Transition.all 0.2
                [ Transition.background
                , Transition.color
                ]

        Solid ->
            Transition.all 0.2
                [ Transition.background
                , Transition.color
                , Transition.border
                ]

        Hollow ->
            Transition.all 0.2
                [ Transition.background
                , Transition.color
                , Transition.border
                ]

        NoFill ->
            Transition.all 0.2
                [ Transition.color
                ]


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
            [ Background.color (regularColor options.color)
            , Font.color Palette.white
            ]

        ( _, Borderless ) ->
            [ Background.color (regularColor options.color)
            , Font.color Palette.white
            ]

        ( _, NoFill ) ->
            [ Font.color (darkerColor options.color)
            ]


fill_ : Options msg -> Attr decorative msg
fill_ options =
    case options.fill of
        Solid ->
            Background.color (regularColor options.color)

        Hollow ->
            Background.color Palette.transparent

        Borderless ->
            Background.color Palette.transparent

        NoFill ->
            Background.color Palette.transparent


borderColor : Options msg -> Attr decorative msg
borderColor options =
    case options.fill of
        Borderless ->
            Border.color Palette.transparent

        NoFill ->
            Border.color Palette.transparent

        _ ->
            Border.color (regularColor options.color)


fontColor : Options msg -> Attr decorative msg
fontColor options =
    case options.fill of
        Solid ->
            Font.color Palette.white

        Hollow ->
            Font.color (fontColor_ options)

        Borderless ->
            Font.color (fontColor_ options)

        NoFill ->
            Font.color (fontColor_ options)


fontColor_ : Options msg -> Element.Color
fontColor_ options =
    case options.shade of
        Dark ->
            regularColor options.color

        Light ->
            lighterColor options.color


regularColor : Color -> Element.Color
regularColor color_ =
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


lighterColor : Color -> Element.Color
lighterColor color_ =
    case color_ of
        Green ->
            Palette.green

        Red ->
            Palette.lightRed

        Grey ->
            Palette.midGrey


label : Options msg -> Element msg
label options =
    case ( options.text, options.icon ) of
        ( Just _, Just icon_ ) ->
            row [ width fill, spacing Scale.extraSmall ]
                [ el [ centerY ] (icon icon_ options)
                , el [ centerY ] (text_ options)
                ]

        ( Nothing, Just icon_ ) ->
            icon icon_ options

        ( _, _ ) ->
            text_ options


iconHover : Options msg -> List (Attribute msg)
iconHover options =
    case ( options.icon, options.hover ) of
        ( Just Ellipsis, True ) ->
            [ Icon.blackHover ]

        ( Just Chevron, True ) ->
            [ Icon.whiteHoverStroke ]

        ( Just _, True ) ->
            [ Icon.whiteHover ]

        ( _, _ ) ->
            []


icon : Icon -> Options msg -> Element msg
icon icon_ options =
    case icon_ of
        Heart ->
            Heart.icon (iconColor options)

        Plus ->
            Plus.icon (iconColor options)

        Cross ->
            Plus.cross (iconColor options)

        Plane ->
            Plane.icon (iconColor options)

        Pencil ->
            Pencil.icon (iconColor options)

        Bin ->
            Bin.icon (iconColor options)

        Ellipsis ->
            Elipsis.icon (iconColor options)

        Chevron ->
            Chevron.down (iconColor options)


iconColor : Options msg -> Element.Color
iconColor options =
    case options.fill of
        Solid ->
            Palette.white

        _ ->
            fontColor_ options


text_ : Options msg -> Element msg
text_ options =
    options.text
        |> Maybe.map (el [ toFontSize options ] << text)
        |> Maybe.withDefault none


toFontSize : Options msg -> Attr decorative msg
toFontSize options =
    case options.size of
        Large ->
            Font.size (Text.medium - 2)

        Medium ->
            Font.size Text.small

        Small ->
            Font.size Text.small
