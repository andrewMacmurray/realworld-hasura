module Program exposing
    ( BlogProgramTest
    , Options
    , baseUrl
    , defaultUser
    , fillField
    , loggedInWithDetails
    , loggedInWithUser
    , onHomePage
    , simulateArticle
    , simulateArticleFeed
    , simulateAuthorFeed
    , start
    , withLoggedInUser
    , withPage
    )

import Api
import Article exposing (Article)
import Article.Feed as Feed exposing (Feed)
import Effect exposing (Effect(..))
import Helpers
import Json.Encode as Encode
import Main
import Ports
import Program.Selector as Selector
import ProgramTest exposing (ProgramDefinition, ProgramTest, SimulatedEffect, SimulatedTask)
import Route exposing (Route)
import SimulatedEffect.Cmd
import SimulatedEffect.Navigation
import SimulatedEffect.Task
import Tag exposing (Tag)
import Test.Html.Query
import Url
import User



-- Program


type alias BlogProgramTest =
    ProgramTest (Main.Model FakeNavKey) Main.Msg (Effect Main.Msg)


type alias BlogProgramDefinition =
    ProgramDefinition Main.Flags (Main.Model FakeNavKey) Main.Msg (Effect Main.Msg)


type alias FakeNavKey =
    ()


type alias Options =
    { homeFeed : Api.Response Feed.Home
    , article : Api.Response (Maybe Article)
    , feed : Api.Response Feed
    , authorFeed : Api.Response (Maybe Feed.ForAuthor)
    , settingsUpdate : Api.Response ()
    , route : Route
    , user : Maybe Ports.User
    }



-- Configure


withPage : Route -> Options
withPage =
    defaultOptions


onHomePage : Options
onHomePage =
    withPage Route.home


withLoggedInUser : Options -> Options
withLoggedInUser options =
    { options | user = Just (user "amacmurray" "a@b.com") }


loggedInWithUser : String -> Options -> Options
loggedInWithUser username options =
    { options | user = Just (user username "b@c.com") }


loggedInWithDetails : Ports.User -> Options -> Options
loggedInWithDetails user_ options =
    { options | user = Just user_ }


defaultUser : Ports.User
defaultUser =
    user "default-user" "a@b.com"


user : String -> String -> Ports.User
user name email =
    { id = 0
    , username = name
    , email = email
    , token = "token"
    , bio = Nothing
    , profileImage = Nothing
    , following = []
    }


simulateArticle : Api.Response (Maybe Article) -> Options -> Options
simulateArticle article options =
    { options | article = article }


simulateArticleFeed : List Article -> List Tag -> Options -> Options
simulateArticleFeed articles tags options =
    { options | homeFeed = Ok (toHomeFeed articles tags) }


simulateAuthorFeed : Api.Response (Maybe Feed.ForAuthor) -> Options -> Options
simulateAuthorFeed feed options =
    { options | authorFeed = feed }


emptyFeed : Feed.Home
emptyFeed =
    toHomeFeed [] []


toHomeFeed : List Article -> List Tag -> Feed.Home
toHomeFeed articles tags =
    { feed = Helpers.feed articles
    , popularTags = List.map (\t -> { tag = t, count = 1 }) tags
    }


defaultOptions : Route -> Options
defaultOptions route =
    { route = route
    , homeFeed = Ok emptyFeed
    , feed = Ok (Helpers.feed [])
    , authorFeed = Ok Nothing
    , article = Ok Nothing
    , user = Nothing
    , settingsUpdate = Ok ()
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
    { user = options.user }


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
            SimulatedEffect.Navigation.pushUrl (Route.routeToString Route.home)

        PushUrl url ->
            SimulatedEffect.Navigation.pushUrl (Url.toString url)

        LoadUrl _ ->
            SimulatedEffect.Cmd.none

        SignUp mut ->
            simulateResponse mut (Ok defaultProfile)

        SignIn mut ->
            simulateResponse mut (Ok defaultProfile)

        LoadUser _ ->
            SimulatedEffect.Cmd.none

        CloseMenu ->
            SimulatedEffect.Cmd.none

        LoadHomeFeed query ->
            simulateResponse query options.homeFeed

        LoadArticle query ->
            simulateResponse query options.article

        LoadFeed query ->
            simulateResponse query options.feed

        LoadAuthorFeed query ->
            simulateResponse query options.authorFeed

        MutateWithEmptyResponse mutation ->
            simulateResponse mutation (Ok ())

        MutationReturningArticle mutation ->
            simulateResponse mutation (Ok (Helpers.article "updated"))

        AddToUserFollows _ ->
            SimulatedEffect.Cmd.none

        RemoveFromUserFollows _ ->
            SimulatedEffect.Cmd.none

        MutateAuthor mutation ->
            simulateResponse mutation (Ok 1)

        MutateSettings mutation ->
            simulateResponse mutation (Ok ())

        UpdateSettings _ ->
            SimulatedEffect.Cmd.none

        RefreshUser _ ->
            SimulatedEffect.Cmd.none

        UpdateUser _ ->
            SimulatedEffect.Cmd.none


simulateResponse : { m | msg : Api.Response a -> msg } -> Api.Response a -> SimulatedEffect msg
simulateResponse { msg } res =
    simulateTask res msg


defaultProfile : User.Profile
defaultProfile =
    Ports.toProfile (user "amacmurray" "a@b.com")


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


fillField : String -> String -> ProgramTest model msg effect -> ProgramTest model msg effect
fillField label content =
    ProgramTest.simulateDomEvent
        (Test.Html.Query.find [ Selector.el label ])
        ( "input", targetValue content )


targetValue : String -> Encode.Value
targetValue val =
    Encode.object [ ( "target", Encode.object [ ( "value", Encode.string val ) ] ) ]
