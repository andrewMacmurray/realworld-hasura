module Page.HomeTest exposing (suite)

import Article exposing (Article)
import Date
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (expectViewHas)
import Route
import Test exposing (..)
import Test.Html.Selector exposing (text)
import Time exposing (Month(..))


suite : Test
suite =
    describe "Home Page"
        [ test "Guest User sees global feed on load" <|
            \_ ->
                Program.withPage Route.Home
                    |> Program.withGlobalFeed [ article "foo", article "bar" ]
                    |> Program.start
                    |> expectViewHas
                        [ el "global-feed"
                        , text "foo"
                        , text "bar"
                        , text "MON JAN 20 2020"
                        ]
        ]


article : String -> Article
article title =
    Article.build 1
        title
        "about something"
        "author"
        "contents"
        (Date.fromCalendarDate 2020 Jan 20)
