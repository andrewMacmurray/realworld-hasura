module SigninTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector as Selector
import ProgramTest exposing (clickButton, ensureViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    test "User is redirected to home when signed in" <|
        \_ ->
            Program.start Route.SignIn
                |> Program.fillField "username" "amacmurray"
                |> Program.fillField "password" "abc123"
                |> ensureViewHas
                    [ Selector.inputWithValue "amacmurray"
                    , Selector.inputWithValue "abc123"
                    ]
                |> clickButton "Sign In"
                |> Expect.pageChange Route.Home
