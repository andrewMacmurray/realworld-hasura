module Element.Anchor exposing
    ( description
    , htmlDescription
    )

import Element
import Html
import Html.Attributes


description : String -> Element.Attribute msg
description =
    htmlDescription >> Element.htmlAttribute


fromLabel : String -> String
fromLabel =
    String.toLower >> String.split " " >> String.join "-"


htmlDescription : String -> Html.Attribute msg
htmlDescription =
    fromLabel >> Html.Attributes.attribute "data-label"
