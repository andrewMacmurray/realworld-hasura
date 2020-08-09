module Element.Layout exposing
    ( Layout
    , authenticated
    , guest
    , halfWidth
    , maxWidth
    , measured
    , toHtml
    , toPage
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
    , width : Width
    }


type alias Banner msg =
    ( List (Attribute msg), Element msg )


type Width
    = Full
    | Measured
    | Half



-- Defaults


default_ profile =
    Layout
        { profile = profile
        , banner = Nothing
        , width = Full
        }



-- Construct


guest : Layout msg
guest =
    default_ Nothing


authenticated : User.Profile -> Layout msg
authenticated profile =
    default_ (Just profile)


user : User -> Layout msg
user user_ =
    case user_ of
        User.Guest ->
            guest

        User.Author profile ->
            authenticated profile



-- Configure


withBanner : List (Attribute msg) -> Element msg -> Layout msg -> Layout msg
withBanner attr el (Layout options) =
    Layout { options | banner = Just ( attr, el ) }


measured : Layout msg -> Layout msg
measured =
    withWidth_ Measured


halfWidth : Layout msg -> Layout msg
halfWidth =
    withWidth_ Half


withWidth_ : Width -> Layout msg -> Layout msg
withWidth_ w (Layout options) =
    Layout { options | width = w }



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


toPage : Element msg -> Layout msg -> Element msg
toPage page (Layout options) =
    column [ width fill, height fill ]
        [ toNavBar options
        , toBanner options
        , el
            [ paddingXY Scale.medium Scale.large
            , constrainBy (toWidth_ options)
            , centerX
            ]
            page
        ]


toBanner : Options msg -> Element msg
toBanner options =
    case options.banner of
        Just b ->
            banner_ options b

        Nothing ->
            none


banner_ : Options msg -> Banner msg -> Element msg
banner_ options ( attrs, content ) =
    el
        (List.concat
            [ [ width fill
              , height (shrink |> minimum 255)
              ]
            , attrs
            ]
        )
        (el
            [ centerX
            , centerY
            , constrainBy (toWidth_ options)
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
                , Route.link Route.NewArticle [] "New Post"
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


toWidth_ : Options msg -> Int
toWidth_ options =
    case options.width of
        Full ->
            maxWidth

        Measured ->
            790

        Half ->
            maxWidth // 2


navItems : List (Element msg) -> Element msg
navItems =
    row [ alignRight, spacing Scale.medium ]


constrainWidth : Attribute msg
constrainWidth =
    width (fill |> maximum maxWidth)


constrainBy : Int -> Attribute msg
constrainBy n =
    width (fill |> maximum n)


maxWidth : number
maxWidth =
    1110
