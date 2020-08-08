module Element.Transition exposing
    ( all
    , background
    , border
    , color
    )

import Element exposing (htmlAttribute)
import Html.Attributes exposing (style)



-- Transition Property


type Property
    = Background Float
    | Border Float
    | Color Float



-- Build


background : Float -> Property
background =
    Background


border : Float -> Property
border =
    Border


color : Float -> Property
color =
    Color



-- Attribute


all : Float -> List (Float -> Property) -> Element.Attribute msg
all duration =
    List.map (toProp duration)
        >> propertiesToString
        >> style "transition"
        >> htmlAttribute



-- Helpers


toProp : Float -> (Float -> Property) -> Property
toProp n p =
    p n


propertiesToString : List Property -> String
propertiesToString =
    List.map propToString >> String.join ", "


propToString : Property -> String
propToString property =
    case property of
        Border n ->
            "border-color " ++ s n ++ " ease"

        Background n ->
            "background " ++ s n ++ " ease"

        Color n ->
            "color " ++ s n ++ " ease"


s : Float -> String
s n =
    String.fromFloat n ++ "s"
