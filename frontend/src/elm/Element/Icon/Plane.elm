module Element.Icon.Plane exposing (icon)

import Element exposing (Color, Element)
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Color -> Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 15 15" ]
            [ Svg.path
                [ d "M.4 0a.4.4 0 00-.4.6L1.5 6 8 7 1.5 8 0 13.5a.4.4 0 00.6.5L14 7.4a.4.4 0 000-.7L.6 0H.4z"
                , fill (Palette.toRgbString color)
                , Icon.hoverTarget
                ]
                []
            ]
        )
