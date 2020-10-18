module Element.Loader.Conduit exposing
    ( alignLeft
    , attributes
    , black
    , default
    , fast
    , loader
    , loaderWithMessage
    , show
    , white
    )

import Animation exposing (Animation)
import Animation.Named as Animation
import Element exposing (..)
import Element.Text as Text
import Element.Transition.Simple as Transition
import Html exposing (Html, div)
import Html.Attributes exposing (style)



-- Loader


type Loader msg
    = Loader (Options msg)


type alias Options msg =
    { style : Style
    , textAlign : TextAlign
    , speed : Speed
    , color : Color
    , attributes : List (Element.Attribute msg)
    }


type Style
    = WithMessage String
    | Icon


type TextAlign
    = Left
    | Center


type Speed
    = Regular
    | Fast


type Color
    = Black
    | White



-- Defaults


defaults : Style -> Options msg
defaults style =
    { style = style
    , textAlign = Center
    , speed = Regular
    , color = White
    , attributes = []
    }



-- Construct


loaderWithMessage : String -> Loader msg
loaderWithMessage =
    WithMessage >> defaults >> Loader


loader : Loader msg
loader =
    Loader (defaults Icon)



-- Configure


white : Loader msg -> Loader msg
white =
    withColor_ White


black : Loader msg -> Loader msg
black =
    withColor_ Black


fast : Loader msg -> Loader msg
fast =
    withSpeed_ Fast


alignLeft : Loader msg -> Loader msg
alignLeft =
    withTextAlign_ Left


attributes : List (Attribute msg) -> Loader msg -> Loader msg
attributes attrs (Loader options) =
    Loader { options | attributes = attrs }


withTextAlign_ : TextAlign -> Loader msg -> Loader msg
withTextAlign_ textAlign (Loader options) =
    Loader { options | textAlign = textAlign }


withColor_ : Color -> Loader msg -> Loader msg
withColor_ color (Loader options) =
    Loader { options | color = color }


withSpeed_ : Speed -> Loader msg -> Loader msg
withSpeed_ speed (Loader options) =
    Loader { options | speed = speed }



-- Preconfigured


default : Element msg
default =
    loader
        |> alignLeft
        |> black
        |> show True



-- Render


show : Bool -> Loader msg -> Element msg
show visible (Loader options) =
    column (List.append (iconBlend options) options.attributes)
        [ html (dots_ visible options)
        , toMessage visible options
        ]


iconBlend : Options msg -> List (Attribute msg)
iconBlend options =
    case options.style of
        Icon ->
            [ htmlAttribute (metaBlendMode options.color) ]

        WithMessage _ ->
            []


toMessage : Bool -> Options msg -> Element msg
toMessage visible options =
    case options.style of
        WithMessage message ->
            Animation.el
                (Animation.fadeIn 500 [ Animation.delay 1400 ])
                [ centerX
                , moveUp 20
                ]
                (Element.el
                    [ Transition.linear 200
                    , Transition.delay 100
                    , alpha (toAlpha visible)
                    ]
                    (Element.el (alignText options.textAlign) (Text.text [ textColor options.color ] message))
                )

        Icon ->
            none


alignText : TextAlign -> List (Element.Attr decorative msg)
alignText align =
    case align of
        Center ->
            []

        Left ->
            [ moveLeft 12, moveDown 5 ]


dots_ : Bool -> Options msg -> Html msg
dots_ visible { color, speed } =
    Animation.div
        (Animation.fadeIn 500
            [ Animation.linear
            , Animation.delay (iconFadeDelay speed)
            ]
        )
        [ style "transform" "translateY(-15px)"
        , style "filter" ("contrast(100) " ++ "opacity(" ++ toOpacity visible ++ ")")
        , style "transition" "0.2s linear"
        , metaBlendMode color
        , style "background" (toMetaBackdrop color)
        , style "border-radius" "30%"
        , style "padding" "10px 20px"
        ]
        [ div []
            [ Animation.div (yoyo speed) (style "position" "absolute" :: meta color) []
            , div (meta color) []
            , div (meta color) []
            , div (meta color) []
            , div (meta color) []
            ]
        ]


iconFadeDelay : Speed -> number
iconFadeDelay speed =
    case speed of
        Regular ->
            1000

        Fast ->
            0


textColor : Color -> Text.Option
textColor color =
    case color of
        White ->
            Text.white

        Black ->
            Text.black


meta : Color -> List (Html.Attribute msg)
meta color =
    [ style "border-radius" "50%"
    , style "width" "20px"
    , style "height" "20px"
    , style "display" "inline-block"
    , style "filter" "blur(5px)"
    , style "margin" "0 5px"
    , style "background" (toMetaColor color)
    ]


metaBlendMode : Color -> Html.Attribute msg
metaBlendMode =
    toMetaBlendMode >> style "mix-blend-mode"


toMetaBlendMode : Color -> String
toMetaBlendMode color =
    case color of
        White ->
            "color-dodge"

        Black ->
            "color-burn"


toMetaBackdrop : Color -> String
toMetaBackdrop color =
    case color of
        White ->
            "black"

        Black ->
            "white"


toMetaColor : Color -> String
toMetaColor color =
    case color of
        White ->
            "#b8b8b8"

        Black ->
            "#484848"


yoyo : Speed -> Animation
yoyo speed =
    Animation.yoyo (yoyoSpeed speed)
        [ Animation.cubic 0.79 0.1 0.3 0.79
        , Animation.infinite
        ]


yoyoSpeed : Speed -> number
yoyoSpeed speed =
    case speed of
        Regular ->
            1400

        Fast ->
            1100


toAlpha : Bool -> number
toAlpha visible =
    if visible then
        1

    else
        0


toOpacity : Bool -> String
toOpacity =
    toAlpha >> String.fromFloat
