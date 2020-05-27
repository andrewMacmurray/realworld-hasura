module SignupTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector as Selector
import ProgramTest exposing (clickButton, ensureViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    test "User can signup" <|
        \_ ->
            Program.start Route.Signup
                |> Program.fillField "email" "a@b.com"
                |> Program.fillField "username" "amacmurray"
                |> Program.fillField "password" "abc123"
                |> ensureViewHas
                    [ Selector.inputWithValue "a@b.com"
                    , Selector.inputWithValue "amacmurray"
                    , Selector.inputWithValue "abc123"
                    ]
                |> clickButton "Sign Up"
                |> Expect.pageChange Route.Home
