module Page.HomeTest exposing (suite)

import Article exposing (Article)
import Helpers
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route
import Tag
import Test exposing (..)


suite : Test
suite =
    describe "Home Page"
        [ test "Guest User sees global feed on load" <|
            \_ ->
                Program.onHomePage
                    |> Program.simulateArticleFeed [ article "foo", article "bar" ] []
                    |> Program.start
                    |> expectViewHas
                        [ el "active-tab-global-feed"
                        , el "article-foo"
                        , el "article-bar"
                        ]
        , test "Logged in user sees personal feed on load" <|
            \_ ->
                Program.onHomePage
                    |> Program.withLoggedInUser
                    |> Program.start
                    |> expectViewHas
                        [ el "active-tab-your-feed"
                        ]
        , test "Shows feed for a particular tag" <|
            \_ ->
                Program.withPage (Route.tagFeed (Tag.one "bread"))
                    |> Program.start
                    |> expectViewHas
                        [ el "active-tab-#bread"
                        ]
        , test "Shows collection of popular tags" <|
            \_ ->
                Program.onHomePage
                    |> Program.simulateArticleFeed [ article "foo", article "bar" ] (Tag.parse "tag1, tag2")
                    |> Program.start
                    |> expectViewHas
                        [ el "popular-tags"
                        , el "popular-tag1"
                        , el "popular-tag2"
                        ]
        , test "Logged in User can like an article" <|
            \_ ->
                Program.withPage Route.home
                    |> Program.withLoggedInUser
                    |> Program.simulateArticleFeed [ article "foo" ] []
                    |> Program.start
                    |> expectViewHas [ el "like-foo" ]
        , test "Logged in User can unlike an article previously liked by them" <|
            \_ ->
                Program.withPage Route.home
                    |> Program.loggedInWithUser "amacmurray"
                    |> Program.simulateArticleFeed [ Helpers.articleLikedBy "amacmurray" { title = "foo" } ] []
                    |> Program.start
                    |> expectViewHas [ el "unlike-foo" ]
        ]


article : String -> Article
article =
    Helpers.article
