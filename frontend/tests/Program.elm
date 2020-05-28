module Program exposing
    ( BlogProgramTest
    , baseUrl
    , clickLink
    , fillField
    , page
    , start
    , withGlobalFeed
    , withUser
    )

import Api
import Article exposing (Article)
import Effect exposing (Effect(..))
import Element.Anchor as Anchor
import Json.Encode as Encode
import Main
import ProgramTest exposing (ProgramDefinition, ProgramTest, SimulatedEffect, SimulatedTask)
import Route exposing (Route)
import SimulatedEffect.Cmd
import SimulatedEffect.Navigation
import SimulatedEffect.Ports
import SimulatedEffect.Task
import Test.Html.Query
import Test.Html.Selector
import Url



-- Program


type alias BlogProgramTest =
    ProgramTest (Main.Model FakeNavKey) Main.Msg (Effect Main.Msg)


type alias BlogProgramDefinition =
    ProgramDefinition Main.Flags (Main.Model FakeNavKey) Main.Msg (Effect Main.Msg)


type alias FakeNavKey =
    ()


type alias Options =
    { globalFeed : Api.Response (List Article)
    , route : Route
    , token : Maybe String
    }



-- Configure


page : Route -> Options
page =
    defaultOptions


withUser : String -> Options -> Options
withUser username options =
    { options | token = Just username }


withGlobalFeed : List Article -> Options -> Options
withGlobalFeed feed options =
    { options | globalFeed = Ok feed }


defaultOptions : Route -> Options
defaultOptions route =
    { route = route
    , globalFeed = Ok []
    , token = Nothing
    }



-- Start


start : Options -> BlogProgramTest
start options =
    program
        |> ProgramTest.withSimulatedEffects (simulateEffects options)
        |> ProgramTest.withBaseUrl (baseUrl ++ Route.routeToString options.route)
        |> ProgramTest.start (toFlags options)


toFlags : Options -> Main.Flags
toFlags options =
    { token = options.token }


baseUrl : String
baseUrl =
    "http://localhost:1234"



-- Definition


program : BlogProgramDefinition
program =
    ProgramTest.createApplication
        { init = init_
        , update = update_
        , view = Main.view
        , onUrlRequest = Main.UrlRequest
        , onUrlChange = Main.UrlChange
        }


init_ : Main.Flags -> Url.Url -> FakeNavKey -> ( Main.Model FakeNavKey, Effect Main.Msg )
init_ flags url key =
    performModelEffect (Main.init flags url key)


update_ : Main.Msg -> Main.Model FakeNavKey -> ( Main.Model FakeNavKey, Effect Main.Msg )
update_ model msg =
    performModelEffect (Main.update model msg)


performModelEffect : ( Main.Model FakeNavKey, Effect msg ) -> ( Main.Model FakeNavKey, Effect msg )
performModelEffect state =
    ( Tuple.first (Effect.perform fakePushUrl state)
    , Tuple.second state
    )


fakePushUrl : FakeNavKey -> String -> Cmd msg
fakePushUrl _ _ =
    Cmd.none



-- Simulated Effects


simulateEffects : Options -> Effect Main.Msg -> SimulatedEffect Main.Msg
simulateEffects options eff =
    case eff of
        None ->
            SimulatedEffect.Cmd.none

        Batch effs ->
            SimulatedEffect.Cmd.batch (List.map (simulateEffects options) effs)

        NavigateTo route ->
            SimulatedEffect.Navigation.pushUrl (Route.routeToString route)

        Logout ->
            SimulatedEffect.Navigation.pushUrl (Route.routeToString Route.Home)

        PushUrl url ->
            SimulatedEffect.Navigation.pushUrl (Url.toString url)

        LoadUrl _ ->
            SimulatedEffect.Cmd.none

        SignUp { msg } ->
            simulateTask (Ok "token") msg

        SignIn { msg } ->
            simulateTask (Ok "token") msg

        SaveToken token ->
            SimulatedEffect.Ports.send "saveToken" (Encode.string token)

        LoadGlobalFeed { msg } ->
            simulateTask options.globalFeed msg


simulateTask : Result err data -> (Result err data -> msg) -> SimulatedEffect msg
simulateTask result msg =
    taskFromResult result |> SimulatedEffect.Task.attempt msg


taskFromResult : Result err data -> SimulatedTask err data
taskFromResult res =
    case res of
        Ok data ->
            SimulatedEffect.Task.succeed data

        Err err ->
            SimulatedEffect.Task.fail err



-- UI Helpers


clickLink : Route -> String -> ProgramTest model msg effect -> ProgramTest model msg effect
clickLink route label =
    ProgramTest.clickLink label (Route.routeToString route)


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
