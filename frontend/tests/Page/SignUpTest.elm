module Page.SignUpTest exposing (suite)

import Expect
import Program
import Program.Expect as Expect
import Program.Selector as Selector exposing (el)
import ProgramTest exposing (clickButton, ensureViewHas, expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    test "User is redirected to home after signup" <|
        \_ ->
            Program.page Route.SignUp
                |> Program.start
                |> Program.fillField "email" "a@b.com"
                |> Program.fillField "username" "amacmurray"
                |> Program.fillField "password" "abc123"
                |> ensureViewHas
                    [ Selector.filledField "a@b.com"
                    , Selector.filledField "amacmurray"
                    , Selector.filledField "abc123"
                    ]
                |> clickButton "Sign Up"
                |> Expect.all
                    [ Expect.redirect Route.Home
                    , expectViewHas [ el "new-post-link" ]
                    ]
