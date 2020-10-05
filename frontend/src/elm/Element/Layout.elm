module Element.Layout exposing
    ( Layout
    , authenticated
    , halfWidth
    , layout
    , maxWidth
    , measured
    , toHtml
    , toPage
    , withBanner
    )

import Element exposing (..)
import Element.Avatar as Avatar
import Element.Layout.Menu as Menu exposing (Menu)
import Element.Scale as Scale
import Element.Text as Text
import Html exposing (Html)
import Route
import Route.Effect as Effect
import User exposing (User)
import Utils.Element as Element



-- Layout


type Layout msg
    = Layout (Options msg)


type alias Options msg =
    { banner : Maybe (Banner msg)
    , width : Width
    }


type alias Banner msg =
    ( List (Attribute msg), Element msg )


type alias Context context =
    { context | user : User, menu : Menu }


type Width
    = Full
    | Measured
    | Half



-- Defaults


default_ : Layout msg
default_ =
    Layout
        { banner = Nothing
        , width = Full
        }


pageXPadding : number
pageXPadding =
    Scale.small



-- Construct


layout : Layout msg
layout =
    default_



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


authenticated : User.Profile -> Context context -> Element msg -> Layout msg -> Element msg
authenticated user context =
    toPage { context | user = User.Author user }


toPage : Context context -> Element msg -> Layout msg -> Element msg
toPage context page (Layout options) =
    column [ width fill, height fill ]
        [ toNavBar context
        , toMobileNav context.menu
        , toBanner options
        , el
            [ paddingXY pageXPadding Scale.large
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


toNavBar : Context context -> Element msg
toNavBar context =
    case context.user of
        User.Author profile_ ->
            navBar context.menu
                [ Route.link (Route.Home Nothing) [] "Home"
                , Route.link Route.NewArticle [] "New Post"
                , Route.el (Route.Author (User.id profile_)) (profileLink profile_)
                , Route.link Route.Settings [] "Settings"
                , Route.link Route.Logout [] "Logout"
                ]

        User.Guest ->
            navBar context.menu
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


navBar : Menu -> List (Element msg) -> Element msg
navBar menu links =
    el
        [ centerX
        , constrainWidth
        , paddingXY pageXPadding 0
        ]
        (row [ width fill ]
            [ Route.el (Route.Home Nothing)
                (el [ paddingXY 0 Scale.medium ]
                    (Text.title [ Text.green, Text.bold ] "conduit")
                )
            , Element.mobileOnly el [ alignRight ] (mobileNavToggle menu)
            , Element.desktopOnly el [ alignRight ] (desktopNav links)
            ]
        )


toMobileNav menu =
    case menu of
        Menu.Open ->
            column [ alignRight ]
                [ Route.link (Route.Home Nothing) [] "Home"
                , Route.link Route.SignIn [] "Sign In"
                , Route.link Route.SignUp [] "Sign Up"
                ]

        Menu.Closed ->
            none


mobileNavToggle : Menu -> Element msg
mobileNavToggle menu =
    case menu of
        Menu.Open ->
            Effect.el Effect.CloseMenu (Text.text [] "Close")

        Menu.Closed ->
            Effect.el Effect.OpenMenu (Text.text [] "Open")


toWidth_ : Options msg -> Int
toWidth_ options =
    case options.width of
        Full ->
            maxWidth

        Measured ->
            790

        Half ->
            maxWidth // 2


desktopNav : List (Element msg) -> Element msg
desktopNav =
    row [ spacing Scale.medium ]


constrainWidth : Attribute msg
constrainWidth =
    width (fill |> maximum maxWidth)


constrainBy : Int -> Attribute msg
constrainBy n =
    width (fill |> maximum n)


maxWidth : number
maxWidth =
    1110
