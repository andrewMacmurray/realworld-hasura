module Utils.Element exposing
    ( desktopOnly
    , maybe
    , mobileOnly
    , showOnDesktop
    , showOnMobile
    )

import Element exposing (Element, el, fill, htmlAttribute, width)
import Html.Attributes exposing (class)



-- Utils


maybe : (a -> Element msg) -> Maybe a -> Element msg
maybe toElement =
    Maybe.map toElement >> Maybe.withDefault Element.none



-- Responsive


mobileOnly : (List (Element.Attribute msg) -> a) -> List (Element.Attribute msg) -> a
mobileOnly node attrs =
    node (attrs ++ [ hideOnDesktop_ ])


desktopOnly : (List (Element.Attribute msg) -> c -> a) -> List (Element.Attribute msg) -> c -> a
desktopOnly node attrs =
    node (attrs ++ [ showOnDesktop_ ])


showOnDesktop : Element msg -> Element msg
showOnDesktop =
    el [ width fill, showOnDesktop_ ]


showOnMobile : Element msg -> Element msg
showOnMobile =
    el [ width fill, hideOnDesktop_ ]


showOnDesktop_ : Element.Attribute msg
showOnDesktop_ =
    htmlAttribute (class "show-on-desktop")


hideOnDesktop_ : Element.Attribute msg
hideOnDesktop_ =
    htmlAttribute (class "hide-on-desktop")
