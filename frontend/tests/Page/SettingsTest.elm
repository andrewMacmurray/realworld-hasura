module Page.SettingsTest exposing (suite)

import Program exposing (defaultUser)
import Program.Selector exposing (filledField)
import ProgramTest exposing (expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Settings Page"
        [ test "User can see their profile information" <|
            \_ ->
                Program.withPage Route.Settings
                    |> Program.loggedInWithDetails { defaultUser | username = "amacmurray", email = "a@b.com" }
                    |> Program.start
                    |> expectViewHas
                        [ filledField "amacmurray"
                        , filledField "a@b.com"
                        ]
        ]
