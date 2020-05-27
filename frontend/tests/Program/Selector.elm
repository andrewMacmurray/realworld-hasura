module Program.Selector exposing
    ( el
    , filledField
    )

import Element.Anchor as Anchor
import Html.Attributes
import Test.Html.Selector exposing (Selector, attribute, tag)


el : String -> Selector
el label =
    Test.Html.Selector.attribute (Anchor.htmlDescription label)


filledField : String -> Selector
filledField val =
    Test.Html.Selector.all
        [ tag "input"
        , attribute (Html.Attributes.value val)
        ]
