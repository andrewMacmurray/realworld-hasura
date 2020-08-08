module Element.Icon.Pencil exposing (icon)

import Element exposing (Color, Element)
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Color -> Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 14 15" ]
            [ Svg.path
                [ d "M11.7.1l-1.3 1.4-.2.2-9 9.7-1 2.9-.2.7.7-.3 2.8-1.2 9-9.8.2-.2 1.2-1.4c.5-.8-1.2-2.6-2.2-2z"
                , fill (Palette.toRgbString color)
                , fillRule "nonzero"
                , Icon.hoverTarget
                ]
                []
            ]
        )
