module Page.NewPostTest exposing (suite)

import Expect
import Program
import Program.Expect as Expect
import Program.Selector exposing (el, fieldError, filledArea, filledField)
import ProgramTest exposing (clickButton, expectView, expectViewHas)
import Route
import Test exposing (..)
import Test.Html.Query as Query


suite : Test
suite =
    describe "New Post Page"
        [ test "User can fill fields for new article" <|
            \_ ->
                Program.withPage Route.NewArticle
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> Program.fillField "article-title" "Title"
                    |> Program.fillField "what's-this-article-about?" "something about the article"
                    |> Program.fillField "write-your-article-(in-markdown)" "some article content"
                    |> expectViewHas
                        [ filledField "Title"
                        , filledField "something about the article"
                        , filledArea "some article content"
                        ]
        , test "User can enter tags" <|
            \_ ->
                Program.withPage Route.NewArticle
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> Program.fillField "enter-tags" "tag1, tag2,tag3"
                    |> expectView hasThreeTags
        , test "User is redirected home after publishing article" <|
            \_ ->
                Program.withPage Route.NewArticle
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> Program.fillField "article-title" "Title"
                    |> Program.fillField "what's-this-article-about?" "something about the article"
                    |> Program.fillField "write-your-article-(in-markdown)" "some article content"
                    |> Program.fillField "enter-tags" "tag"
                    |> clickButton "Publish Article"
                    |> Expect.redirectHome
        , test "User sees errors if submitting an incomplete article" <|
            \_ ->
                Program.withPage Route.NewArticle
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> Program.fillField "article-title" "Title"
                    |> clickButton "Publish Article"
                    |> expectViewHas
                        [ fieldError "what's-this-article-about?"
                        , fieldError "write-your-article-(in-markdown)"
                        ]
        ]


hasThreeTags : Query.Single msg -> Expect.Expectation
hasThreeTags =
    Query.findAll [ el "visible-tag" ] >> Query.count (Expect.equal 3)
