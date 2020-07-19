module Page.SettingsTest exposing (suite)

import Program exposing (defaultUser)
import Program.Selector exposing (fieldError, filledArea, filledField)
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
        , test "User can edit their profile information" <|
            \_ ->
                Program.withPage Route.Settings
                    |> Program.loggedInWithDetails { defaultUser | username = "amacmurray", email = "a@b.com" }
                    |> Program.start
                    |> Program.fillField "profile-image-url" "http://www.bread.com/bread.png"
                    |> Program.fillField "a-short-bio-about-you" "i love bread"
                    |> expectViewHas
                        [ filledField "http://www.bread.com/bread.png"
                        , filledArea "i love bread"
                        ]
        , test "user cannot update settings with empty username or email" <|
            \_ ->
                Program.withPage Route.Settings
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> Program.fillField "username" ""
                    |> Program.fillField "email" ""
                    |> expectViewHas
                        [ fieldError "username"
                        , fieldError "email"
                        ]
        ]
