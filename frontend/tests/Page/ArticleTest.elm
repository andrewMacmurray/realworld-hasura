module Page.ArticleTest exposing (..)

import Article exposing (Article)
import Graphql.Http exposing (HttpError(..), RawError(..))
import Helpers
import Program exposing (defaultUser)
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route
import Test exposing (..)


suite : Test
suite =
    describe "Article Page"
        [ test "User sees article on successful load" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok (Just article))
                    |> Program.start
                    |> expectViewHas [ el "article-title" ]
        , test "User sees not found message if server does not find article for given id" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok Nothing)
                    |> Program.start
                    |> expectViewHas [ el "not-found-message" ]
        , test "User sees failure message if server returns an error" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Err serverError)
                    |> Program.start
                    |> expectViewHas [ el "error-message" ]
        , test "Logged in user can follow an author" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok (Just (articleBy 2 "someone")))
                    |> Program.loggedInWithUser "amacmurray"
                    |> Program.start
                    |> expectViewHas [ el "follow-someone" ]
        , test "Logged in user can unfollow a previously followed author" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle (Ok (Just (articleBy 2 "someone")))
                    |> Program.loggedInWithDetails { defaultUser | following = [ 2 ] }
                    |> Program.start
                    |> expectViewHas [ el "unfollow-someone" ]
        ]


articlePage : Route.Route
articlePage =
    Route.Article 1


articleBy : Int -> String -> Article
articleBy =
    Helpers.articleBy


article : Article
article =
    Helpers.article "An Article"


serverError : Graphql.Http.Error a
serverError =
    HttpError NetworkError
