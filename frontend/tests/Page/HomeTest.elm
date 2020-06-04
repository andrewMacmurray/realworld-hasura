module Page.HomeTest exposing (suite)

import Article exposing (Article)
import Helpers
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route
import Tag
import Test exposing (..)
import Test.Html.Selector exposing (text)


suite : Test
suite =
    describe "Home Page"
        [ test "Guest User sees global feed on load" <|
            \_ ->
                Program.onHomePage
                    |> Program.simulateGlobalFeed [ article "foo", article "bar" ] []
                    |> Program.start
                    |> expectViewHas
                        [ el "global-feed"
                        , el "article-foo"
                        , el "article-bar"
                        , text "MON JAN 20 2020"
                        ]
        , test "Shows collection of popular tags" <|
            \_ ->
                Program.onHomePage
                    |> Program.simulateGlobalFeed [ article "foo", article "bar" ] (Tag.parse "tag1, tag2")
                    |> Program.start
                    |> expectViewHas
                        [ el "popular-tags"
                        , el "popular-tag1"
                        , el "popular-tag2"
                        ]
        , test "Shows feed for a particular tag" <|
            \_ ->
                Program.withPage (Route.tagFeed (Tag.one "bread"))
                    |> Program.start
                    |> expectViewHas
                        [ el "tag-feed-for-bread"
                        ]
        , test "Logged in User can like an article" <|
            \_ ->
                Program.withPage Route.home
                    |> Program.login
                    |> Program.simulateGlobalFeed [ article "foo" ] []
                    |> Program.start
                    |> Program.clickEl "like-foo"
                    |> Program.expectMutationContaining [ "like_article" ]
        , test "Logged in User can unlike an article previously liked by them" <|
            \_ ->
                Program.withPage Route.home
                    |> Program.loginWithDetails "amacmurray" "a@b.com"
                    |> Program.simulateGlobalFeed [ Helpers.articleLikedBy "amacmurray" { title = "foo" } ] []
                    |> Program.start
                    |> Program.clickEl "unlike-foo"
                    |> Program.expectMutationContaining [ "unlike_article" ]
        ]


article : String -> Article
article =
    Helpers.article
