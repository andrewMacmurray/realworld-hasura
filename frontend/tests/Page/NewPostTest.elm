module Page.NewPostTest exposing (suite)

import Expect
import Program
import Program.Selector exposing (el, filledArea, filledField)
import ProgramTest exposing (expectView, expectViewHas)
import Route
import Test exposing (..)
import Test.Html.Query as Query


suite : Test
suite =
    describe "New Post Page"
        [ test "User can fill fields for new article" <|
            \_ ->
                Program.page Route.NewPost
                    |> Program.login
                    |> Program.start
                    |> Program.fillField "article-title" "Title"
                    |> Program.fillField "what's-this-article-about?" "something about the article"
                    |> Program.fillField "write-your-article-(in-markdown)" "some article content"
                    |> expectViewHas
                        [ filledField "Title"
                        , filledField "something about the article"
                        , filledArea "some article content"
                        ]
        , test "User can enter tags without special characters" <|
            \_ ->
                Program.page Route.NewPost
                    |> Program.login
                    |> Program.start
                    |> Program.fillField "enter-tags" "tag1, tag2,tag3"
                    |> expectView hasThreeTags
        ]


hasThreeTags : Query.Single msg -> Expect.Expectation
hasThreeTags =
    Query.findAll [ el "visible-tag" ] >> Query.count (Expect.equal 3)