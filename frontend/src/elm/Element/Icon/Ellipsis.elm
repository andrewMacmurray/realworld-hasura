module Element.Icon.Ellipsis exposing (icon)

import Element exposing (Color, Element)
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Color -> Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 17 15" ]
            [ Svg.g
                [ fill (Palette.toRgbString color)
                , fillRule "evenodd"
                , Icon.hoverTarget
                ]
                [ Svg.circle [ cx "6", cy "2", r "2" ] []
                , Svg.circle [ cx "6", cy "13", r "2" ] []
                , Svg.circle [ cx "6", cy "7.5", r "2" ] []
                ]
            ]
        )
