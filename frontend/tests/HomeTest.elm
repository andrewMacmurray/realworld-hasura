module HomeTest exposing (..)

import Article exposing (Article)
import Expect
import Program
import Program.Selector exposing (el)
import ProgramTest exposing (ensureViewHas, expectView)
import Route
import Test exposing (..)
import Test.Html.Query as Query


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
                    |> ensureViewHas [ el "global-feed" ]
                    |> expectView (hasArticles articles)
        ]


article : String -> Article
article title =
    Article.build title "about something"


hasArticles : List Article -> Query.Single msg -> Expect.Expectation
hasArticles items =
    Query.findAll [ el "article" ] >> Query.count (Expect.equal (List.length items))
