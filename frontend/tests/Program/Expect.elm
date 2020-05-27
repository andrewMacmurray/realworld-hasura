module Program.Expect exposing (pageChange)

import Expect
import Program exposing (BlogProgramTest, baseUrl)
import ProgramTest
import Route


pageChange : Route.Route -> BlogProgramTest -> Expect.Expectation
pageChange route =
    ProgramTest.expectBrowserUrl (\s -> Expect.equal (baseUrl ++ Route.routeToString route) s)
