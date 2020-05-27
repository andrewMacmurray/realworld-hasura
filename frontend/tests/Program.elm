module Program exposing
    ( BlogProgramTest
    , asGuest
    , baseUrl
    , fillField
    , start
    , withDefaults
    , withGlobalFeed
    )

import Api
import Article exposing (Article)
import Effect exposing (Effect(..))
import Element.Anchor as Anchor
import Json.Encode as Encode
import Main
import ProgramTest exposing (ProgramDefinition, ProgramTest, SimulatedEffect)
import Route exposing (Route)
import SimulatedEffect.Cmd
import SimulatedEffect.Navigation
import SimulatedEffect.Ports
import SimulatedEffect.Task
import Test.Html.Query
import Test.Html.Selector
import Url



-- Test Program


type alias BlogProgramTest =
    ProgramTest (Main.Model ()) Main.Msg (Effect Main.Msg)


type alias Options =
    { globalFeed : Api.Response (List Article)
    , route : Route
    , token : Maybe String
    }


asGuest : Route -> Options
asGuest route =
    defaultOptions route


start : Options -> BlogProgramTest
start options =
    program
        |> ProgramTest.withSimulatedEffects (simulateEffects options)
        |> ProgramTest.withBaseUrl (baseUrl ++ Route.routeToString options.route)
        |> ProgramTest.start (toFlags options)


withGlobalFeed : List Article -> Options -> Options
withGlobalFeed feed options =
    { options | globalFeed = Ok feed }


withDefaults : Options -> Options
withDefaults =
    identity


toFlags : Options -> Main.Flags
toFlags options =
    { token = options.token }


defaultOptions : Route -> Options
defaultOptions route =
    { route = route
    , globalFeed = Ok []
    , token = Nothing
    }


baseUrl : String
baseUrl =
    "http://localhost:1234"


type alias BlogProgramDefinition =
    ProgramDefinition Main.Flags (Main.Model ()) Main.Msg (Effect Main.Msg)


program : BlogProgramDefinition
program =
    ProgramTest.createApplication
        { init = init
        , update = update
        , view = Main.view
        , onUrlRequest = Main.UrlRequest
        , onUrlChange = Main.UrlChange
        }


update msg model =
    Main.update msg model |> Effect.applyUpdate


init flags_ url key =
    Main.init flags_ url key |> Effect.applyUpdate


simulateEffects : Options -> Effect Main.Msg -> SimulatedEffect Main.Msg
simulateEffects options eff =
    case eff of
        None ->
            SimulatedEffect.Cmd.none

        Batch effs ->
            SimulatedEffect.Cmd.batch (List.map (simulateEffects options) effs)

        NavigateTo route ->
            SimulatedEffect.Navigation.pushUrl (Route.routeToString route)

        PushUrl url ->
            SimulatedEffect.Navigation.pushUrl (Url.toString url)

        LoadUrl _ ->
            SimulatedEffect.Cmd.none

        SignUp msg _ ->
            SimulatedEffect.Task.succeed "token!" |> SimulatedEffect.Task.attempt msg

        SignIn msg _ ->
            SimulatedEffect.Task.succeed "token!" |> SimulatedEffect.Task.attempt msg

        SaveToken token ->
            SimulatedEffect.Ports.send "saveToken" (Encode.string token)

        LoadGlobalFeed msg _ ->
            taskFromResult options.globalFeed |> SimulatedEffect.Task.attempt msg


taskFromResult res =
    case res of
        Ok data ->
            SimulatedEffect.Task.succeed data

        Err err ->
            SimulatedEffect.Task.fail err



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
