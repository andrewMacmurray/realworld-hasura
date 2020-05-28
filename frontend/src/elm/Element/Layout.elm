module Element.Layout exposing
    ( guest
    , halfWidth
    , loggedIn
    , maxWidth
    )

import Element exposing (..)
import Element.Font as Font
import Element.Palette as Palette
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
            , Route.link Route.NewPost "New Post"
            , Route.link Route.Settings "Settings"
            ]
        , column
            [ paddingXY Scale.medium 0
            , constrainWidth
            , centerX
            ]
            els
        ]


halfWidth : Element msg -> Element msg
halfWidth =
    el [ width (fill |> maximum (maxWidth // 2)), centerX ]


navbar : List (Element msg) -> Element msg
navbar links =
    el
        [ centerX
        , constrainWidth
        , paddingXY Scale.medium 0
        ]
        (row [ width fill ]
            [ Route.el Route.Home (Text.subtitle [ Font.color Palette.green, paddingXY 0 Scale.medium ] "conduit")
            , navItems links
            ]
        )


navItems : List (Element msg) -> Element msg
navItems =
    row [ alignRight, spacing Scale.medium ]


constrainWidth =
    width (fill |> maximum maxWidth)


maxWidth : number
maxWidth =
    1110
