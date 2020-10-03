module Element.Loading exposing (dots)

import Animation exposing (Animation)
import Animation.Named as Animation
import Element exposing (Element, alpha, centerX, column, html, htmlAttribute, moveUp)
import Element.Text as Text
import Html exposing (..)
import Html.Attributes exposing (class, style)


type alias Options =
    { message : String, visible : Bool }


dots : Options -> Element msg
dots { message, visible } =
    column []
        [ html (dots_ visible)
        , Animation.el
            (Animation.fadeIn 500 [ Animation.delay 1300 ])
            [ centerX
            , moveUp 20
            ]
            (Element.el
                [ style_ "transition" "0.2s linear"
                , style_ "transition-delay" "0.1s"
                , alpha (toAlpha visible)
                ]
                (Text.text [ Text.white ] message)
            )
        ]


dots_ : Bool -> Html msg
dots_ visible =
    Animation.div
        (Animation.fadeIn 500
            [ Animation.linear
            , Animation.delay 500
            ]
        )
        [ style "transform" "translateY(-15px)"
        , style "filter" ("contrast(100) " ++ "opacity(" ++ toOpacity visible ++ ")")
        , style "transition" "0.2s linear"
        , style "mix-blend-mode" "color-dodge"
        , style "background" "black"
        , style "padding" "10px 20px"
        ]
        [ div [ class "wrap" ]
            [ Animation.div yoyo [ class "meta", style "position" "absolute" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            ]
        ]


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


style_ : String -> String -> Element.Attribute msg
style_ a b =
    htmlAttribute (style a b)
