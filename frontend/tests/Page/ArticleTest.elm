module Page.ArticleTest exposing (..)

import Article exposing (Article)
import Helpers
import Program exposing (defaultUser)
import Program.Expect exposing (noEl)
import Program.Selector exposing (el)
import ProgramTest exposing (ensureViewHas, expectView, expectViewHas)
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
                    |> Program.simulateArticle (Err Helpers.serverError)
                    |> Program.start
                    |> expectViewHas [ el "error-message" ]
        , test "Logged in user can follow an author" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle articleResponse
                    |> Program.loggedInWithUser "amacmurray"
                    |> Program.start
                    |> expectViewHas [ el "follow-someone" ]
        , test "Logged in user can unfollow a previously followed author" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle articleResponse
                    |> Program.loggedInWithDetails { defaultUser | following = [ 2 ] }
                    |> Program.start
                    |> expectViewHas [ el "unfollow-someone" ]
        , test "Logged in user can post a comment" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle articleResponse
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> expectViewHas [ el "comments", el "post-new-comment" ]
        , test "Guest user cannot post comment" <|
            \_ ->
                Program.withPage articlePage
                    |> Program.simulateArticle articleResponse
                    |> Program.start
                    |> ensureViewHas [ el "comments" ]
                    |> expectView (noEl "post-new-comment")
        ]


articleResponse =
    Ok (Just (articleBy 2 "someone"))


articlePage : Route.Route
articlePage =
    Route.Article 1


articleBy : Int -> String -> Article
articleBy =
    Helpers.articleBy


article : Article
article =
    Helpers.article "An Article"
