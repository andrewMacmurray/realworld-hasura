module Element.Layout exposing
    ( Layout
    , authenticated
    , guest
    , halfWidth
    , maxWidth
    , padded
    , toElement
    , toHtml
    , user
    , withBanner
    )

import Element exposing (..)
import Element.Avatar as Avatar
import Element.Scale as Scale
import Element.Text as Text
import Html exposing (Html)
import Route
import User exposing (User)



-- Layout


type Layout msg
    = Layout (Options msg)


type alias Options msg =
    { profile : Maybe User.Profile
    , banner : Maybe (Banner msg)
    }


type alias Banner msg =
    ( List (Attribute msg), Element msg )



-- Construct


guest : Layout msg
guest =
    Layout
        { profile = Nothing
        , banner = Nothing
        }


authenticated : User.Profile -> Layout msg
authenticated profile =
    Layout
        { profile = Just profile
        , banner = Nothing
        }


user : User -> Layout msg
user user_ =
    case user_ of
        User.Guest ->
            guest

        User.LoggedIn profile ->
            authenticated profile



-- Configure


withBanner : List (Attribute msg) -> Element msg -> Layout msg -> Layout msg
withBanner attr el (Layout options) =
    Layout { options | banner = Just ( attr, el ) }



-- To Html


toHtml : Element msg -> Html msg
toHtml =
    layoutWith { options = layoutOptions } []


layoutOptions : List Element.Option
layoutOptions =
    [ focusStyle
        { borderColor = Nothing
        , backgroundColor = Nothing
        , shadow = Nothing
        }
    ]



-- Render


toElement : List (Element msg) -> Layout msg -> Element msg
toElement els (Layout options) =
    column [ width fill ]
        [ toNavBar options
        , toBanner options
        , column
            [ paddingXY Scale.medium Scale.large
            , constrainWidth
            , centerX
            ]
            els
        ]


padded : Element msg -> Element msg
padded =
    el [ width (fill |> maximum (maxWidth - (Scale.large * 6))), centerX ]


halfWidth : Element msg -> Element msg
halfWidth =
    el [ width (fill |> maximum (maxWidth // 2)), centerX ]


toBanner : Options msg -> Element msg
toBanner options =
    case options.banner of
        Just b ->
            banner_ b

        Nothing ->
            none


banner_ : Banner msg -> Element msg
banner_ ( attrs, content ) =
    el
        (List.concat
            [ [ width fill
              , height (fill |> minimum 255)
              ]
            , attrs
            ]
        )
        (el
            [ centerX
            , centerY
            , constrainWidth
            , paddingXY Scale.medium (Scale.large * 2)
            ]
            content
        )


toNavBar : Options msg -> Element msg
toNavBar options =
    case options.profile of
        Just profile_ ->
            navBar
                [ Route.link (Route.Home Nothing) [] "Home"
                , Route.link Route.NewPost [] "New Post"
                , Route.el (Route.Author (User.id profile_)) (profileLink profile_)
                , Route.link Route.Settings [] "Settings"
                , Route.link Route.Logout [] "Logout"
                ]

        Nothing ->
            navBar
                [ Route.link (Route.Home Nothing) [] "Home"
                , Route.link Route.SignIn [] "Sign In"
                , Route.link Route.SignUp [] "Sign Up"
                ]


profileLink : User.Profile -> Element msg
profileLink profile =
    row [ spacing Scale.extraSmall ]
        [ Avatar.small (User.profileImage profile)
        , Text.link [] (User.username profile)
        ]


navBar : List (Element msg) -> Element msg
navBar links =
    el
        [ centerX
        , constrainWidth
        , paddingXY Scale.medium 0
        ]
        (row [ width fill ]
            [ Route.el (Route.Home Nothing)
                (el [ paddingXY 0 Scale.medium ]
                    (Text.title [ Text.green, Text.bold ] "conduit")
                )
            , navItems links
            ]
        )


navItems : List (Element msg) -> Element msg
navItems =
    row [ alignRight, spacing Scale.medium ]


constrainWidth : Attribute msg
constrainWidth =
    width (fill |> maximum maxWidth)


maxWidth : number
maxWidth =
    1110
