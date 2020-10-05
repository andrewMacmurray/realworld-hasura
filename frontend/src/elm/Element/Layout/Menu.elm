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
                , transition 300
                , style "max-height" "180px"
                ]
                (drawer_ links)

        Closed ->
            Element.mobileOnly el
                [ alignRight
                , transition 300
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
            , transition 200
            , transitionDelay 100
            , rotate (degrees 45)
            , spacing 5
            ]
            [ line -9
            , el
                [ width fill
                , transition 100
                , transitionDelay 100
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
            , transition 200
            , rotate (degrees 0)
            ]
            [ line 0
            , el
                [ width fill
                , transition 200
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
        , style "transition" "0.2s ease-out"
        , Border.rounded 50
        , width fill
        , moveUp moveBy
        , height (px 4)
        ]
        none


transition : Int -> Attribute msg
transition n =
    style "transition" (ms n ++ " ease")


transitionDelay : Int -> Attribute msg
transitionDelay n =
    style "transition-delay" (ms n)


ms : Int -> String
ms n =
    String.fromInt n ++ "ms"


style : String -> String -> Attribute msg
style a b =
    htmlAttribute (Html.Attributes.style a b)
