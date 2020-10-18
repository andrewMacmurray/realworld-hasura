module Element.Loader.Spinner exposing (spinner)

import Animation
import Animation.Named as Animation
import Element exposing (Element, html)
import Element.Palette as Palette
import Html
import Html.Attributes


spinner : Element.Color -> Element msg
spinner color =
    let
        border =
            borderSize ++ " solid "

        borderSolid =
            border ++ Palette.toRgbString color

        gap =
            border ++ "transparent"
    in
    fadeIn []
        (html
            (Html.div
                [ Html.Attributes.style "animation" "spin 0.7s linear infinite"
                , Html.Attributes.style "border-radius" "50%"
                , Html.Attributes.style "border-top" borderSolid
                , Html.Attributes.style "border-right" borderSolid
                , Html.Attributes.style "border-bottom" borderSolid
                , Html.Attributes.style "border-left" gap
                , Html.Attributes.style "width" toSize
                , Html.Attributes.style "height" toSize
                ]
                []
            )
        )


fadeIn : List (Element.Attribute msg) -> Element msg -> Element msg
fadeIn =
    Animation.el (Animation.fadeIn 300 [ Animation.delay 200 ])


toSize : String
toSize =
    px_ 8


borderSize : String
borderSize =
    px_ 2


px_ : Float -> String
px_ n =
    String.fromFloat n ++ "px"
