module Element.Transition exposing (all)

import Element exposing (htmlAttribute)
import Html.Attributes exposing (style)


all : Element.Attribute msg
all =
    htmlAttribute (style "transition" "0.2s ease")
