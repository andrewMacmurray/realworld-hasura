module Element.Avatar exposing
    ( large
    , medium
    , small
    )

import Element exposing (..)
import Html.Attributes exposing (class)


small : Maybe String -> Element msg
small =
    image_ 25


medium : Maybe String -> Element msg
medium =
    image_ 35


large : Maybe String -> Element msg
large =
    image_ 45


image_ : Int -> Maybe String -> Element msg
image_ size src =
    Element.image
        [ width (px size)
        , height (px size)
        , htmlAttribute (class "circular-image")
        ]
        { src = defaultIfNoProfileImage src
        , description = "avatar-image"
        }


defaultIfNoProfileImage : Maybe String -> String
defaultIfNoProfileImage =
    Maybe.withDefault "https://static.productionready.io/images/smiley-cyrus.jpg"
