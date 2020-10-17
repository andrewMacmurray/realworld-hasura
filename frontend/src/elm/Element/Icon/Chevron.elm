module Element.Icon.Chevron exposing (down)

import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


down color =
    Icon.small
        (Svg.svg [ viewBox "0 0 18 15", width "100%" ]
            [ Svg.g
                [ stroke (Palette.toRgbString color)
                , fill "none"
                , fillRule "evenodd"
                , Icon.hoverTarget
                ]
                [ Svg.path [ d "M2.5 4.5l7 8", strokeWidth "2.5", strokeLinecap "round" ] []
                , Svg.path [ d "M16.5 4.5l-7 8", strokeWidth "2.5", strokeLinecap "round" ] []
                ]
            ]
        )
