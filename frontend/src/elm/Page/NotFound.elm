module Page.NotFound exposing (view)

import Element exposing (Element)
import Element.Layout as Layout
import Element.Text as Text


view : Element msg
view =
    Layout.guest
        [ Text.title [] "Not Found"
        ]
