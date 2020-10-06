module Element.Icon.Plus exposing (cross, icon)

import Element exposing (Color, Element, el)
import Element.Icon as Icon
import Element.Palette as Palette
import Element.Transition.Simple as Transition
import Svg
import Svg.Attributes exposing (..)


cross : Color -> Element msg
cross =
    icon_ 135


icon : Color -> Element msg
icon =
    icon_ 0


icon_ : Float -> Color -> Element msg
icon_ degrees_ color =
    el
        [ Element.rotate (degrees degrees_)
        , Transition.ease 300
        ]
        (Icon.small
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
        )
