module Element.Transition.Simple exposing
    ( delay
    , ease
    , easeOut
    , linear
    )

import Element exposing (htmlAttribute)
import Html.Attributes



-- Eases


linear : Int -> Element.Attribute msg
linear =
    all_ "linear"


ease : Int -> Element.Attribute msg
ease =
    all_ "ease"


easeOut : Int -> Element.Attribute msg
easeOut =
    all_ "ease-out"



-- Delay


delay : Int -> Element.Attribute msg
delay ms =
    style "transition-delay" (millis ms)



-- Helpers


all_ : String -> Int -> Element.Attribute msg
all_ ease_ ms =
    style "transition" (millis ms ++ " " ++ ease_)


style : String -> String -> Element.Attribute msg
style a b =
    htmlAttribute (Html.Attributes.style a b)


millis : Int -> String
millis n =
    String.fromInt n ++ "ms"
