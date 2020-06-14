module Element.Tab exposing
    ( active
    , link
    , tabs
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Divider as Divider
import Element.Events exposing (onClick)
import Element.Scale as Scale
import Element.Text as Text


tabs : List (Element msg) -> Element msg
tabs els =
    column [ width fill, spacing Scale.large ]
        [ row [ spacing Scale.large, width fill ] els
        , Divider.divider
        ]


active : String -> Element msg
active text =
    el [ Anchor.description ("active-tab-" ++ text) ] (greenSubtitle text)


link : msg -> String -> Element msg
link msg text =
    el [ onClick msg ] (subtitleLink text)


subtitleLink : String -> Element msg
subtitleLink =
    Text.subtitle [ Text.asLink ]


greenSubtitle : String -> Element msg
greenSubtitle =
    Text.subtitle [ Text.green ]
