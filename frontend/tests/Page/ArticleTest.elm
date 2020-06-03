module Page.ArticleTest exposing (..)

import Article exposing (Article)
import Graphql.Http exposing (HttpError(..), RawError(..))
import Helpers
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Article Page"
        [ test "User sees article on successful load" <|
            \_ ->
                Program.withPage (Route.Article 1)
                    |> Program.withArticle (Ok (Just article))
                    |> Program.start
                    |> expectViewHas [ el "article-title" ]
        , test "User sees not found message if server does not find article for given id" <|
            \_ ->
                Program.withPage (Route.Article 2)
                    |> Program.withArticle (Ok Nothing)
                    |> Program.start
                    |> expectViewHas [ el "not-found-message" ]
        , test "User sees failure message if server returns an error" <|
            \_ ->
                Program.withPage (Route.Article 2)
                    |> Program.withArticle (Err serverError)
                    |> Program.start
                    |> expectViewHas [ el "error-message" ]
        ]


article : Article
article =
    Helpers.article "An Article"


serverError : Graphql.Http.Error a
serverError =
    HttpError NetworkError
