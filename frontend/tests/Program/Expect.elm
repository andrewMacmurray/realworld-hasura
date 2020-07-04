module Program.Expect exposing (noEl, redirect, redirectHome)

import Expect exposing (Expectation)
import Program exposing (BlogProgramTest, baseUrl)
import Program.Selector exposing (el)
import ProgramTest
import Route exposing (Route)
import Test.Html.Query as Query


noEl : String -> Query.Single msg -> Expect.Expectation
noEl label =
    Query.findAll [ el label ] >> Query.count (Expect.equal 0)


redirect : Route -> BlogProgramTest -> Expectation
redirect route =
    ProgramTest.expectBrowserUrl (\s -> Expect.equal (baseUrl ++ Route.routeToString route) s)


redirectHome : BlogProgramTest -> Expectation
redirectHome =
    redirect (Route.Home Nothing)
