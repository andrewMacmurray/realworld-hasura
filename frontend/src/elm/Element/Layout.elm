module Element.Layout exposing
    ( constrained
    , guest
    , loggedIn
    , maxWidth
    )

import Element exposing (..)
import Element.Scale as Scale
import Element.Text as Text
import Route
import User



-- Layout


guest : List (Element msg) -> Element msg
guest els =
    column [ width fill ]
        [ navbar
            [ Route.link Route.Home "Home"
            , Route.link Route.SignIn "Sign In"
            , Route.link Route.SignUp "Sign Up"
            ]
        , column
            [ paddingXY Scale.medium 0
            , constrainWidth
            , centerX
            ]
            els
        ]


loggedIn : User.Profile -> List (Element msg) -> Element msg
loggedIn profile els =
    column [ width fill ]
        [ navbar
            [ Route.link Route.Home "Home"
            , Text.link [] "New Post"
            ]
        , column
            [ paddingXY Scale.medium 0
            , constrainWidth
            , centerX
            ]
            els
        ]


navbar : List (Element msg) -> Element msg
navbar links =
    el
        [ centerX
        , constrainWidth
        , paddingXY Scale.medium 0
        ]
        (row [ width fill ]
            [ Route.el Route.Home (Text.subtitle [ paddingXY 0 Scale.medium ] "conduit")
            , navItems links
            ]
        )


navItems =
    row [ alignRight, spacing Scale.medium ]


constrained : Element msg -> Element msg
constrained =
    el [ constrainWidth, centerX ]


constrainWidth =
    width (fill |> maximum maxWidth)


maxWidth : number
maxWidth =
    1110
