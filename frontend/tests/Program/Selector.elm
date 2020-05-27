module Program.Selector exposing (inputWithValue)

import Html.Attributes
import Test.Html.Selector exposing (Selector, attribute, tag)


inputWithValue : String -> Selector
inputWithValue val =
    Test.Html.Selector.all
        [ tag "input"
        , attribute (Html.Attributes.value val)
        ]
