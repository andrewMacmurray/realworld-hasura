module Element.Icon.Plus exposing (icon)

import Element exposing (Color, Element)
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Color -> Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 16 15", width "100%" ]
            [ Svg.g
                [ fill (Palette.toRgbString color)
                , Icon.hoverTarget
                ]
                [ Svg.rect [ x "7", width "2", height "15", rx "1" ] []
                , Svg.path [ d "M15.5 7.5a1 1 0 01-1 1h-13a1 1 0 010-2h13a1 1 0 011 1z" ] []
                ]
            ]
        )
