module Page.AuthorTest exposing (suite)

import Article exposing (Article)
import Article.Author exposing (Author)
import Helpers
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route exposing (Route)
import Test exposing (..)


suite : Test
suite =
    describe "Author Page"
        [ test "User sees authored articles on load" <|
            \_ ->
                Program.withPage authorRoute
                    |> Program.simulateAuthorFeed (Ok (Just { articles = [ article "foo", article "bar" ], author = author }))
                    |> Program.start
                    |> expectViewHas
                        [ el "active-tab-by-author"
                        , el "article-foo"
                        , el "article-bar"
                        ]
        , test "User sees not found message if no author" <|
            \_ ->
                Program.withPage authorRoute
                    |> Program.simulateAuthorFeed (Ok Nothing)
                    |> Program.start
                    |> expectViewHas
                        [ el "not-found-message"
                        ]
        , test "User sees error message if server error" <|
            \_ ->
                Program.withPage authorRoute
                    |> Program.simulateAuthorFeed (Err Helpers.serverError)
                    |> Program.start
                    |> expectViewHas
                        [ el "error-message"
                        ]
        ]


authorRoute : Route
authorRoute =
    Route.Author 1


author : Author
author =
    Helpers.author 1 "username"


article : String -> Article
article =
    Helpers.article
