module HomeTest exposing (..)

import Article exposing (Article)
import Date
import Expect
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (ensureViewHas, expectView)
import Route
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text)
import Time exposing (Month(..))


suite : Test
suite =
    describe "Home"
        [ test "Guest User sees global feed on load" <|
            \_ ->
                let
                    articles =
                        [ article "foo"
                        , article "bar"
                        ]
                in
                Program.asGuest Route.Home
                    |> Program.withGlobalFeed articles
                    |> Program.start
                    |> ensureViewHas
                        [ el "global-feed"
                        , text "MON JAN 20 2020"
                        ]
                    |> expectView (hasArticles articles)
        ]


article : String -> Article
article title =
    Article.build title
        "about something"
        "author"
        (Date.fromCalendarDate 2020 Jan 20)


hasArticles : List Article -> Query.Single msg -> Expect.Expectation
hasArticles items =
    Query.findAll [ el "article" ] >> Query.count (expectEqualCount items)


expectEqualCount : List a -> Int -> Expect.Expectation
expectEqualCount =
    Expect.equal << List.length
