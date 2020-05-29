module Element.Avatar exposing
    ( large
    , medium
    )

import Element exposing (..)
import Html.Attributes exposing (class)


medium : String -> Element msg
medium =
    image_ 35


large : String -> Element msg
large =
    image_ 45


image_ : Int -> String -> Element msg
image_ size src =
    Element.image
        [ width (px size)
        , height (px size)
        , htmlAttribute (class "circular-image")
        ]
        { src = src
        , description = "avatar-image"
        }
