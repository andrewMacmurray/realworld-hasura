module Page.SignInTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector exposing (el, filledField)
import ProgramTest exposing (clickButton, ensureViewHas, expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Sign In Page"
        [ test "User is redirected to home when signed in" <|
            \_ ->
                Program.withPage Route.SignIn
                    |> Program.start
                    |> Program.fillField "username" "amacmurray"
                    |> Program.fillField "password" "abc123"
                    |> ensureViewHas
                        [ filledField "amacmurray"
                        , filledField "abc123"
                        ]
                    |> clickButton "Sign In"
                    |> Expect.redirectHome
        , test "User sees authenticated navbar items when signed in" <|
            \_ ->
                Program.withPage Route.SignIn
                    |> Program.start
                    |> ensureViewHas [ el "sign-in-link" ]
                    |> Program.fillField "username" "amacmurray"
                    |> Program.fillField "password" "abc123"
                    |> clickButton "Sign In"
                    |> expectViewHas [ el "new-post-link" ]
        ]
