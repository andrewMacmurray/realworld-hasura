module Element.Layout.Block exposing (halfWidth)

import Element exposing (..)
import Element.Layout as Layout


halfWidth : Element msg -> Element msg
halfWidth =
    el [ width (fill |> maximum (Layout.maxWidth // 2)) ]
