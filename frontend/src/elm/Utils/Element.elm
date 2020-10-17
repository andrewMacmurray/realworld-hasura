module Utils.Element exposing
    ( desktopOnly
    , maybe
    , mobileOnly
    )

import Element exposing (Element, htmlAttribute)
import Html.Attributes exposing (class)



-- Utils


maybe : (a -> Element msg) -> Maybe a -> Element msg
maybe toElement =
    Maybe.map toElement >> Maybe.withDefault Element.none



-- Responsive


mobileOnly : (List (Element.Attribute msg) -> a) -> List (Element.Attribute msg) -> a
mobileOnly node attrs =
    node (attrs ++ [ hideOnDesktop ])


desktopOnly : (List (Element.Attribute msg) -> c -> a) -> List (Element.Attribute msg) -> c -> a
desktopOnly node attrs =
    node (attrs ++ [ showOnDesktop ])


showOnDesktop : Element.Attribute msg
showOnDesktop =
    htmlAttribute (class "show-on-desktop")


hideOnDesktop : Element.Attribute msg
hideOnDesktop =
    htmlAttribute (class "hide-on-desktop")
