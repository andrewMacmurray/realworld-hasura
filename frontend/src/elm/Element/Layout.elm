module Element.Layout exposing
    ( constrained
    , maxWidth
    , page
    )

import Element exposing (..)
import Element.Scale as Scale
import Element.Text as Text
import Route



-- Layout


page : List (Element msg) -> Element msg
page els =
    column [ width fill ]
        [ navbar
        , column
            [ paddingXY Scale.medium 0
            , constrainWidth
            , centerX
            ]
            els
        ]


navbar : Element msg
navbar =
    el
        [ centerX
        , constrainWidth
        , paddingXY Scale.medium 0
        ]
        (row [ width fill ]
            [ Route.el Route.Home (Text.subtitle [ paddingXY 0 Scale.medium ] "conduit")
            , navItems
            ]
        )


navItems =
    row [ alignRight, spacing Scale.medium ]
        [ Route.link Route.Home "Home"
        , Route.link Route.SignIn "Sign In"
        , Route.link Route.SignUp "Sign Up"
        ]


constrained : Element msg -> Element msg
constrained =
    el [ constrainWidth, centerX ]


constrainWidth =
    width (fill |> maximum maxWidth)


maxWidth : number
maxWidth =
    1110
