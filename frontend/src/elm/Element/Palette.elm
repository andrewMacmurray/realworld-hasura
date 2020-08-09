module Element.Palette exposing
    ( black
    , darkGreen
    , darkRed
    , deepGreen
    , green
    , grey
    , lightGrey
    , lightRed
    , midGrey
    , red
    , toRgbString
    , transparent
    , white
    )

import Element exposing (Color, rgb255, rgba255, toRgb)


green : Color
green =
    rgb255 92 184 92


darkGreen : Color
darkGreen =
    rgb255 55 110 55


deepGreen : Color
deepGreen =
    rgb255 16 82 16


red : Color
red =
    rgb255 201 45 20


lightRed : Color
lightRed =
    rgb255 255 98 73


darkRed : Color
darkRed =
    rgb255 184 92 92


grey : Color
grey =
    rgb255 149 149 149


midGrey : Color
midGrey =
    rgb255 188 188 188


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



-- To RGB String


toRgbString : Color -> String
toRgbString color =
    let
        c =
            toRgb color
    in
    String.concat
        [ "rgb("
        , String.fromInt (to255RgbValue c.red)
        , ", "
        , String.fromInt (to255RgbValue c.green)
        , ", "
        , String.fromInt (to255RgbValue c.blue)
        , ")"
        ]


to255RgbValue : Float -> Int
to255RgbValue value =
    if value <= 1 then
        round (value * 255)

    else
        round value
