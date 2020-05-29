module Page.SettingsTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector exposing (el, filledField)
import ProgramTest exposing (clickButton, ensureViewHas, expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Settings"
        [ test "User can logout" <|
            \_ ->
                Program.page Route.Settings
                    |> Program.login
                    |> Program.start
                    |> ensureViewHas [ el "settings-title", el "logout" ]
                    |> clickButton "Logout"
                    |> ensureViewHas [ el "sign-in-link", el "sign-up-link" ]
                    |> Expect.redirect Route.Home
        , test "User can see their profile information" <|
            \_ ->
                Program.page Route.Settings
                    |> Program.loginWithDetails "amacmurray" "a@b.com"
                    |> Program.start
                    |> expectViewHas
                        [ filledField "amacmurray"
                        , filledField "a@b.com"
                        ]
        ]
