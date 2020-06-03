module Element.Icon exposing (enableHover, hoverTarget, small)

import Element exposing (..)
import Html.Attributes
import Svg exposing (Svg)
import Svg.Attributes


small : Svg msg -> Element msg
small =
    el [ width (px 17), height (px 15) ] << html


enableHover : Element.Attribute msg
enableHover =
    htmlAttribute (Html.Attributes.class "icon-white-hover")


hoverTarget : Svg.Attribute msg
hoverTarget =
    Svg.Attributes.class "icon-white-hover-target"
