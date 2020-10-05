module Page.NotFound exposing (view)

import Context exposing (Context)
import Element exposing (Element)
import Element.Layout as Layout
import Element.Text as Text


view : Context -> Element msg
view context =
    Layout.layout |> Layout.toPage context (Text.title [] "Not Found")
