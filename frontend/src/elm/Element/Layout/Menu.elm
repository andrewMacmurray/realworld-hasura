module Element.Layout.Menu exposing
    ( Menu(..)
    , drawer
    , hamburgerClosed
    , hamburgerOpen
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Transition.Simple as Transition
import Html.Attributes
import Utils.Element as Element



-- Menu State


type Menu
    = Open
    | Closed



-- Drawer


drawer : Menu -> List (Element msg) -> Element msg
drawer menu links =
    case menu of
        Open ->
            Element.mobileOnly el
                [ alignRight
                , Transition.ease 300
                , style "max-height" "180px"
                ]
                (drawer_ links)

        Closed ->
            Element.mobileOnly el
                [ alignRight
                , Transition.ease 300
                , style "max-height" "0"
                ]
                (drawer_ links)


drawer_ : List (Element msg) -> Element msg
drawer_ links =
    column
        [ alignRight
        , centerX
        , paddingEach { edges | right = Scale.medium, bottom = Scale.large }
        , spacing Scale.small
        ]
        (drawerLinks links)


drawerLinks : List (Element msg) -> List (Element msg)
drawerLinks =
    List.map (el [ alignRight ])



-- Hamburger


hamburgerOpen : Element msg
hamburgerOpen =
    el
        [ padding Scale.extraSmall ]
        (column
            [ width (px 35)
            , Transition.ease 200
            , Transition.delay 100
            , rotate (degrees 45)
            , spacing 5
            ]
            [ line -9
            , el
                [ width fill
                , Transition.ease 100
                , Transition.delay 100
                , rotate (degrees 90)
                ]
                (line 0)
            , line 9
            ]
        )


hamburgerClosed : Element msg
hamburgerClosed =
    el
        [ padding Scale.extraSmall ]
        (column
            [ width (px 35)
            , spacing 5
            , Transition.ease 200
            , rotate (degrees 0)
            ]
            [ line 0
            , el
                [ width fill
                , Transition.ease 200
                , rotate (degrees 0)
                ]
                (line 0)
            , line 0
            ]
        )


line : Float -> Element msg
line moveBy =
    el
        [ Background.color Palette.darkGreen
        , Transition.easeOut 200
        , Border.rounded 50
        , width fill
        , moveUp moveBy
        , height (px 4)
        ]
        none


style : String -> String -> Attribute msg
style a b =
    htmlAttribute (Html.Attributes.style a b)
