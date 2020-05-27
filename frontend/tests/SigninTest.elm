module SigninTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector as Selector exposing (el)
import ProgramTest exposing (clickButton, ensureViewHas, expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Sign In"
        [ test "User is redirected to home when signed in" <|
            \_ ->
                Program.start Route.SignIn
                    |> Program.fillField "username" "amacmurray"
                    |> Program.fillField "password" "abc123"
                    |> ensureViewHas
                        [ Selector.filledField "amacmurray"
                        , Selector.filledField "abc123"
                        ]
                    |> clickButton "Sign In"
                    |> Expect.pageChange Route.Home
        , test "User sees authenticated navbar items when signed in" <|
            \_ ->
                Program.start Route.SignIn
                    |> ensureViewHas
                        [ el "sign-in-link"
                        , el "sign-up-link"
                        , el "home-link"
                        ]
                    |> Program.fillField "username" "amacmurray"
                    |> Program.fillField "password" "abc123"
                    |> clickButton "Sign In"
                    |> expectViewHas
                        [ el "home-link"
                        , el "new-post-link"
                        ]
        ]
