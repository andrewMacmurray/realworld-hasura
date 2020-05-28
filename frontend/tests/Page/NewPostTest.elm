module Page.NewPostTest exposing (suite)

import Program
import Program.Selector as Selector
import ProgramTest exposing (expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    test "User can create a new post" <|
        \_ ->
            Program.page Route.NewPost
                |> Program.login
                |> Program.start
                |> Program.fillField "article-title" "Title"
                |> Program.fillField "what's-this-article-about?" "something about the article"
                |> Program.fillField "write-your-article-(in-markdown)" "some article content"
                |> expectViewHas
                    [ Selector.filledField "Title"
                    , Selector.filledField "something about the article"
                    , Selector.filledArea "some article content"
                    ]
