module Page.SettingsTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector exposing (el)
import ProgramTest exposing (clickButton, ensureViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Settings"
        [ test "User can logout" <|
            \_ ->
                Program.page Route.Settings
                    |> Program.withUser "amacmurray"
                    |> Program.start
                    |> ensureViewHas [ el "settings-title", el "logout" ]
                    |> clickButton "Logout"
                    |> ensureViewHas [ el "sign-in-link", el "sign-up-link" ]
                    |> Expect.redirect Route.Home
        ]
