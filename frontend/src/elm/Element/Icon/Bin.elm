module Element.Icon.Bin exposing (icon)

import Element exposing (Color, Element)
import Element.Icon as Icon
import Element.Palette as Palette
import Svg
import Svg.Attributes exposing (..)


icon : Color -> Element msg
icon color =
    Icon.small
        (Svg.svg [ viewBox "0 0 13 15" ]
            [ Svg.g
                [ fill (Palette.toRgbString color)
                , fillRule "nonzero"
                , Icon.hoverTarget
                ]
                [ Svg.path [ d binPath ] []
                , Svg.path [ d lidPath ] []
                ]
            ]
        )


binPath : String
binPath =
    "M11.2 4.7H1v8.2c0 1 .6 1.8 1.5 2l.4.1h6.5c1-.2 1.8-1 1.8-2.1v-8-.2zM3.8 9v3.7c-.1.3-.3.5-.6.4-.2 0-.4-.2-.4-.5V12v-2V7c0-.3.2-.6.5-.5.3 0 .5.2.5.5v2zm2.8.9V12.7c0 .3-.3.4-.5.4-.3 0-.5-.2-.5-.5v-1.2-4.2V7c0-.3.3-.5.5-.4.3 0 .5.2.5.5v2.8zm2.8 0V12.6c0 .3-.3.5-.5.4-.3 0-.5-.2-.5-.5v-2.2-3.2V7c0-.3.3-.4.5-.4.3 0 .5.2.5.4v2.8z"


lidPath : String
lidPath =
    "M12.2 2.8c0-.6-.3-1-.9-1H8.8V.8C8.8.3 8.5 0 8 0H4.1c-.4 0-.7.3-.7.7V2H.8c-.4 0-.7.2-.8.7v.3c0 .5.3.8.9.8h10.5c.4 0 .7-.2.8-.7v-.2z"
