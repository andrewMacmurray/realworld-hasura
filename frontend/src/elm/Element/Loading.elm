module Element.Loading exposing (spinner)

import Animation
import Animation.Named as Animation
import Element exposing (Element, centerX, column, html, moveUp)
import Element.Text as Text
import Html exposing (..)
import Html.Attributes exposing (class, style)


spinner : Element msg
spinner =
    column []
        [ html spinner_
        , Animation.el
            (Animation.fadeIn 300 [ Animation.delay 1000 ])
            [ centerX
            , moveUp 20
            ]
            (Text.text [ Text.white ] "Loading...")
        ]


spinner_ : Html msg
spinner_ =
    Animation.div
        (Animation.fadeIn 500
            [ Animation.linear
            , Animation.delay 500
            ]
        )
        [ class "meta-container", style "transform" "translateY(-15px)" ]
        [ div [ class "wrap" ]
            [ div [ class "meta meta-move" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            , div [ class "meta" ] []
            ]
        ]
