module Element.Transition exposing (colors)

import Element exposing (htmlAttribute)
import Html.Attributes exposing (style)


colors : Element.Attribute msg
colors =
    htmlAttribute (style "transition" "background 0.2s ease, border-color 0.2s ease, color 0.2s ease")
