module Program.Selector exposing
    ( el
    , fieldError
    , filledArea
    , filledField
    )

import Element.Anchor as Anchor
import Html.Attributes
import Test.Html.Selector exposing (Selector, all, attribute, tag)


el : String -> Selector
el label =
    Test.Html.Selector.attribute (Anchor.htmlDescription label)


fieldError : String -> Selector
fieldError label =
    el (label ++ "-error")


filledField : String -> Selector
filledField val =
    all
        [ tag "input"
        , attribute (Html.Attributes.value val)
        ]


filledArea : String -> Selector
filledArea val =
    all
        [ tag "textarea"
        , attribute (Html.Attributes.value val)
        ]
