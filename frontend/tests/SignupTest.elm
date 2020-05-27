module SignupTest exposing (suite)

import Program
import Program.Expect as Expect
import Program.Selector as Selector
import ProgramTest exposing (clickButton, ensureViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    test "User is redirected to home after signup" <|
        \_ ->
            Program.start Route.SignUp
                |> Program.fillField "email" "a@b.com"
                |> Program.fillField "username" "amacmurray"
                |> Program.fillField "password" "abc123"
                |> ensureViewHas
                    [ Selector.filledField "a@b.com"
                    , Selector.filledField "amacmurray"
                    , Selector.filledField "abc123"
                    ]
                |> clickButton "Sign Up"
                |> Expect.pageChange Route.Home
