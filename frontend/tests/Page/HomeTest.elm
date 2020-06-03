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
                    |> Program.withGlobalFeed [ article "foo", article "bar" ] []
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
                    |> Program.withGlobalFeed [ article "foo", article "bar" ] (Tag.parse "tag1, tag2")
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
        ]


article : String -> Article
article =
    Helpers.article
