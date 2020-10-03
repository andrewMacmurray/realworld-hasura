module Animation exposing
    ( Animation
    , Ease
    , Option
    , cubic
    , delay
    , div
    , el
    , element
    , embed
    , infinite
    , linear
    , named
    )

import Element exposing (Element, htmlAttribute)
import Html exposing (Html)
import Html.Attributes exposing (style)



-- Animation


type Animation
    = Animation Animation_


type alias Animation_ =
    { name : String
    , duration : Float
    , options : List Option
    }


type Option
    = Delay Float
    | Infinite
    | Timing Ease


type Ease
    = Linear
    | EaseInOut
    | Cubic Float Float Float Float



-- Construct


named : String -> Float -> List Option -> Animation
named name duration options =
    Animation { name = name, duration = duration, options = options }



-- Options


delay : Float -> Option
delay =
    Delay


linear : Option
linear =
    Timing Linear


cubic : Float -> Float -> Float -> Float -> Option
cubic a b c d =
    Timing (Cubic a b c d)


infinite : Option
infinite =
    Infinite



-- Render


embed : Animation -> Element msg -> Element msg
embed anim =
    el anim [ Element.width Element.fill ]


element : Animation -> (List (Element.Attribute msg) -> element) -> List (Element.Attribute msg) -> element
element (Animation { name, duration, options }) node_ attrs =
    node_ (attrs ++ List.map htmlAttribute (toAnimation name duration options))


el : Animation -> List (Element.Attribute msg) -> Element msg -> Element msg
el (Animation { name, duration, options }) attrs =
    Element.el (attrs ++ List.map htmlAttribute (toAnimation name duration options))


div : Animation -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
div (Animation { name, duration, options }) attrs =
    Html.div (attrs ++ toAnimation name duration options)


toAnimation : String -> Float -> List Option -> List (Html.Attribute msg)
toAnimation name duration options =
    withOptions options (style "animation" (animationStyle name duration))


withOptions : List Option -> Html.Attribute msg -> List (Html.Attribute msg)
withOptions options anim =
    anim :: List.map toOption options


toOption : Option -> Html.Attribute msg
toOption option =
    case option of
        Infinite ->
            style "animation-iteration-count" "infinite"

        Delay float ->
            style "animation-delay" (ms float)

        Timing ease ->
            style "animation-timing-function" (toEase ease)


toEase : Ease -> String
toEase ease =
    case ease of
        EaseInOut ->
            "ease-in-out"

        Linear ->
            "linear"

        Cubic a b c d ->
            String.join " "
                [ "cubic-bezier("
                , String.fromFloat a
                , ","
                , String.fromFloat b
                , ","
                , String.fromFloat c
                , ","
                , String.fromFloat d
                , ")"
                ]


animationStyle : String -> Float -> String
animationStyle name duration =
    String.join " " [ name, ms duration, "both" ]


ms : Float -> String
ms n =
    String.fromFloat n ++ "ms"
