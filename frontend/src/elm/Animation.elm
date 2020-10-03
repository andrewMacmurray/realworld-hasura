module Animation exposing
    ( Animation
    , Ease
    , Option
    , delay
    , div
    , el
    , linear
    , named
    , node
    )

import Element exposing (htmlAttribute)
import Html
import Html.Attributes exposing (style)


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


node (Animation { name, duration, options }) node_ attrs =
    node_ (attrs ++ List.map htmlAttribute (toAnimation name duration options))


el (Animation { name, duration, options }) attrs =
    Element.el (attrs ++ List.map htmlAttribute (toAnimation name duration options))


div (Animation { name, duration, options }) attrs =
    Html.div (attrs ++ toAnimation name duration options)


named : String -> Float -> List Option -> Animation
named name duration options =
    Animation { name = name, duration = duration, options = options }


delay : Float -> Option
delay =
    Delay


linear : Option
linear =
    Timing Linear


toAnimation name duration options =
    withOptions options (style "animation" (toAnimation_ name duration))


withOptions options anim =
    anim :: List.map toOption options


toOption option =
    case option of
        Infinite ->
            style "animation-iteration-count" "infinite"

        Delay float ->
            style "animation-delay" (ms float)

        Timing ease ->
            style "animation-timing-function" (toEase ease)


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


toAnimation_ name duration =
    String.join " " [ name, ms duration, "both" ]


ms n =
    String.fromFloat n ++ "ms"
