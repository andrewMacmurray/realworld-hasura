module Program.Expect exposing
    ( contains
    , hasNoEls
    , redirect
    , redirectHome
    , redirectToPublishedArticle
    )

import Expect exposing (Expectation)
import Program exposing (BlogProgramTest, baseUrl)
import Program.Selector exposing (el)
import ProgramTest
import Route exposing (Route)
import Test.Html.Query as Query


hasNoEls : String -> Query.Single msg -> Expect.Expectation
hasNoEls =
    contains 0


contains : Int -> String -> Query.Single msg -> Expectation
contains n label =
    Query.findAll [ el label ] >> Query.count (Expect.equal n)


redirect : Route -> BlogProgramTest -> Expectation
redirect route =
    ProgramTest.expectBrowserUrl (\s -> Expect.equal (baseUrl ++ Route.routeToString route) s)


redirectToPublishedArticle : BlogProgramTest -> Expectation
redirectToPublishedArticle =
    redirect (Route.Article 1)


redirectHome : BlogProgramTest -> Expectation
redirectHome =
    redirect Route.home
