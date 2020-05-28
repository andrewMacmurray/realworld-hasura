module Element.Divider exposing (divider)

import Element exposing (..)
import Element.Border as Border
import Element.Palette as Palette


divider : Element msg
divider =
    el
        [ Border.width 1
        , Border.color Palette.lightGrey
        , width fill
        ]
        none
