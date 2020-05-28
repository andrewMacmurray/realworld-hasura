module Element.Palette exposing
    ( black
    , darkGreen
    , green
    , grey
    , lightGrey
    , transparent
    , white
    )

import Element exposing (Color, rgb255, rgba255)


green : Color
green =
    rgb255 92 184 92


darkGreen : Color
darkGreen =
    rgb255 55 110 55


grey : Color
grey =
    rgb255 149 149 149


lightGrey : Color
lightGrey =
    rgb255 243 243 243


white : Color
white =
    rgb255 255 255 255


black : Color
black =
    rgb255 56 58 60


transparent : Color
transparent =
    rgba255 0 0 0 0
