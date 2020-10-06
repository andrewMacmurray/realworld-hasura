module Element.Loader exposing
    ( black
    , white
    )

import Animation exposing (Animation)
import Animation.Named as Animation
import Element exposing (Element, alpha, centerX, column, html, moveDown, moveLeft, moveUp)
import Element.Text as Text
import Element.Transition.Simple as Transition
import Html exposing (..)
import Html.Attributes exposing (style)


type alias Options =
    { message : String
    , visible : Bool
    }


type Align
    = Left
    | Right


type Color
    = Black
    | White


white : Options -> Element msg
white =
    loader Right White


black : Options -> Element msg
black =
    loader Left Black


loader : Align -> Color -> Options -> Element msg
loader size color { message, visible } =
    column []
        [ html (dots_ color visible)
        , Animation.el
            (Animation.fadeIn 500 [ Animation.delay 1400 ])
            [ centerX
            , moveUp 20
            ]
            (Element.el
                [ Transition.linear 200
                , Transition.delay 100
                , alpha (toAlpha visible)
                ]
                (Element.el (alignText size) (Text.text [ textColor color ] message))
            )
        ]


alignText : Align -> List (Element.Attr decorative msg)
alignText align =
    case align of
        Right ->
            []

        Left ->
            [ moveLeft 12, moveDown 5 ]


dots_ : Color -> Bool -> Html msg
dots_ color visible =
    Animation.div
        (Animation.fadeIn 500
            [ Animation.linear
            , Animation.delay 1000
            ]
        )
        [ style "transform" "translateY(-15px)"
        , style "filter" ("contrast(100) " ++ "opacity(" ++ toOpacity visible ++ ")")
        , style "transition" "0.2s linear"
        , style "mix-blend-mode" (toMetaBlendMode color)
        , style "background" (toMetaBackdrop color)
        , style "padding" "10px 20px"
        ]
        [ div []
            [ Animation.div yoyo (style "position" "absolute" :: meta color) []
            , div (meta color) []
            , div (meta color) []
            , div (meta color) []
            , div (meta color) []
            ]
        ]


textColor : Color -> Text.Option
textColor color =
    case color of
        White ->
            Text.white

        Black ->
            Text.black


meta : Color -> List (Attribute msg)
meta color =
    [ style "border-radius" "50%"
    , style "width" "20px"
    , style "height" "20px"
    , style "display" "inline-block"
    , style "filter" "blur(5px)"
    , style "margin" "0 5px"
    , style "background" (toMetaColor color)
    ]


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


yoyo : Animation
yoyo =
    Animation.yoyo 1400
        [ Animation.cubic 0.79 0.1 0.3 0.79
        , Animation.infinite
        ]


toAlpha : Bool -> number
toAlpha visible =
    if visible then
        1

    else
        0


toOpacity : Bool -> String
toOpacity =
    toAlpha >> String.fromFloat
