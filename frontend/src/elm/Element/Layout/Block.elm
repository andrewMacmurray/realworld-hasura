module Element.Layout.Block exposing (halfWidthPlus)

import Element exposing (..)
import Element.Layout as Layout


halfWidthPlus : Int -> Element msg -> Element msg
halfWidthPlus extra =
    el [ width (fill |> maximum ((Layout.maxWidth // 2) + extra)) ]
