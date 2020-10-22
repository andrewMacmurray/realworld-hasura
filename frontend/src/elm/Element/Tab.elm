module Element.Tab exposing
    ( active
    , link
    , tabs
    )

import Element exposing (..)
import Element.Anchor as Anchor
import Element.Background as Background
import Element.Events exposing (onClick)
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Utils.Element exposing (wrappedRow_)


tabs : List (Element msg) -> Element msg
tabs els =
    wrappedRow_
        [ width fill
        , spacing Scale.large
        , paddingEach { edges | bottom = Scale.large }
        ]
        els


active : String -> Element msg
active text =
    el
        [ Anchor.description ("active-tab-" ++ text)
        , below
            (el
                [ width fill
                , height (px 2)
                , Background.color Palette.darkGreen
                , moveDown Scale.extraSmall
                ]
                none
            )
        ]
        (greenSubtitle text)


link : msg -> String -> Element msg
link msg text =
    el [ onClick msg ] (subtitleLink text)


subtitleLink : String -> Element msg
subtitleLink =
    Text.subtitle [ Text.pointer ]


greenSubtitle : String -> Element msg
greenSubtitle =
    Text.subtitle [ Text.darkGreen, Text.pointer ]
