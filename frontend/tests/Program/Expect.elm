module Program.Expect exposing (redirect, redirectHome)

import Expect exposing (Expectation)
import Program exposing (BlogProgramTest, baseUrl)
import ProgramTest
import Route exposing (Route)


redirect : Route -> BlogProgramTest -> Expectation
redirect route =
    ProgramTest.expectBrowserUrl (\s -> Expect.equal (baseUrl ++ Route.routeToString route) s)


redirectHome : BlogProgramTest -> Expectation
redirectHome =
    redirect (Route.Home Nothing)
