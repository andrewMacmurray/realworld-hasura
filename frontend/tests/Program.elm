module Program exposing
    ( BlogProgramTest
    , baseUrl
    , fillField
    , start
    )

import Effect exposing (Effect(..))
import Element.Anchor as Anchor
import Json.Encode as Encode
import Main
import ProgramTest exposing (ProgramDefinition, ProgramTest, SimulatedEffect)
import Route
import SimulatedEffect.Cmd
import SimulatedEffect.Navigation
import SimulatedEffect.Task
import Test.Html.Query
import Test.Html.Selector
import Url



-- Test Program


type alias BlogProgramTest =
    ProgramTest (Main.Model ()) Main.Msg (Effect Main.Msg)


start : Route.Route -> BlogProgramTest
start route =
    program
        |> ProgramTest.withSimulatedEffects simulateEffects
        |> ProgramTest.withBaseUrl (baseUrl ++ Route.routeToString route)
        |> ProgramTest.start ()


baseUrl : String
baseUrl =
    "http://localhost:1234"


type alias BlogProgramDefinition =
    ProgramDefinition Main.Flags (Main.Model ()) Main.Msg (Effect Main.Msg)


program : BlogProgramDefinition
program =
    ProgramTest.createApplication
        { init = Main.init
        , update = Main.update
        , view = Main.view
        , onUrlRequest = Main.UrlRequest
        , onUrlChange = Main.UrlChange
        }


simulateEffects : Effect Main.Msg -> SimulatedEffect Main.Msg
simulateEffects eff =
    case eff of
        None ->
            SimulatedEffect.Cmd.none

        NavigateTo route ->
            SimulatedEffect.Navigation.pushUrl (Route.routeToString route)

        PushUrl url ->
            SimulatedEffect.Navigation.pushUrl (Url.toString url)

        LoadUrl _ ->
            SimulatedEffect.Cmd.none

        Signup msg _ ->
            SimulatedEffect.Task.succeed "token!" |> SimulatedEffect.Task.attempt msg



-- UI Helpers


fillField : String -> String -> ProgramTest model msg effect -> ProgramTest model msg effect
fillField label content =
    ProgramTest.simulateDomEvent
        (Test.Html.Query.find
            [ Test.Html.Selector.attribute (Anchor.htmlDescription label)
            ]
        )
        ( "input", targetValue content )


targetValue : String -> Encode.Value
targetValue val =
    Encode.object [ ( "target", Encode.object [ ( "value", Encode.string val ) ] ) ]
