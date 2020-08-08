module Element.Icon exposing (blackHover, hoverTarget, small, whiteHover)

import Element exposing (..)
import Html.Attributes
import Svg exposing (Svg)
import Svg.Attributes


small : Svg msg -> Element msg
small =
    el [ width (px 17), height (px 15) ] << html


whiteHover : Element.Attribute msg
whiteHover =
    htmlAttribute (Html.Attributes.class "icon-white-hover")


blackHover : Attribute msg
blackHover =
    htmlAttribute (Html.Attributes.class "icon-black-hover")


hoverTarget : Svg.Attribute msg
hoverTarget =
    Svg.Attributes.class "icon-hover-target"
