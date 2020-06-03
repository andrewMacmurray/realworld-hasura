module Element.Icon.Heart exposing (icon)

import Element
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Element.Color -> Element.Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 101 88", width "100%" ]
            [ Svg.path
                [ d path_
                , fill (Palette.toRgbString color)
                , fillRule "nonzero"
                , Icon.hoverTarget
                ]
                []
            ]
        )


path_ : String
path_ =
    "M13.441 50.606C4.727 42.054.942 32.679.942 24.29.942 9.982 10.483.441 24.953.441c13.484 0 18.096 6.252 25.989 15.297C58.836 6.693 63.44.441 76.925.441c14.477 0 24.018 9.541 24.018 23.849 0 8.389-3.784 17.765-12.498 26.316L50.942 87.942 13.441 50.606z"
