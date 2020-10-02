module Utils.Element exposing (desktopOnly)

import Element exposing (htmlAttribute)
import Html.Attributes exposing (class)


desktopOnly : (List (Element.Attribute msg) -> c -> a) -> List (Element.Attribute msg) -> c -> a
desktopOnly node attrs children =
    node (attrs ++ [ showOnDesktop ]) children


showOnDesktop : Element.Attribute msg
showOnDesktop =
    htmlAttribute (class "show-on-desktop")
