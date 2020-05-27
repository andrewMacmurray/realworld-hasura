module Effect exposing
    ( Effect(..)
    , batch
    , loadGlobalFeed
    , loadUrl
    , map
    , navigateTo
    , none
    , perform
    , pushUrl
    , saveToken
    , signIn
    , signUp
    )

import Api
import Article exposing (Article)
import Browser.Navigation as Navigation
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Ports
import Route exposing (Route)
import Url exposing (Url)
import User exposing (User)



-- Effect


type Effect msg
    = None
    | Batch (List (Effect msg))
    | PushUrl Url
    | LoadUrl String
    | NavigateTo Route
    | SaveToken String
    | SignUp (Api.Response String -> msg) (SelectionSet String RootMutation)
    | SignIn (Api.Response String -> msg) (SelectionSet String RootMutation)
    | LoadGlobalFeed (Api.Response (List Article) -> msg) (SelectionSet (List Article) RootQuery)


none =
    None


batch =
    Batch


saveToken =
    SaveToken


signUp =
    SignUp


signIn =
    SignIn


pushUrl =
    PushUrl


navigateTo =
    NavigateTo


loadUrl =
    LoadUrl


loadGlobalFeed =
    LoadGlobalFeed



-- Transform


map : (a -> msg) -> Effect a -> Effect msg
map toMsg effect =
    case effect of
        None ->
            None

        Batch effs ->
            Batch (List.map (map toMsg) effs)

        NavigateTo route ->
            NavigateTo route

        SaveToken token ->
            SaveToken token

        SignUp msg mut ->
            SignUp (msg >> toMsg) mut

        SignIn msg mut ->
            SignIn (msg >> toMsg) mut

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url

        LoadGlobalFeed msg query ->
            LoadGlobalFeed (msg >> toMsg) query



-- Perform


type alias Model model key =
    { model | user : User, navKey : key }


perform : (key -> String -> Cmd msg) -> ( Model model key, Effect msg ) -> ( Model model key, Cmd msg )
perform pushUrl_ ( model, effect ) =
    case effect of
        None ->
            ( model, Cmd.none )

        Batch effs ->
            doBatch pushUrl_ model effs

        NavigateTo route ->
            ( model, pushUrl_ model.navKey (Route.routeToString route) )

        PushUrl url ->
            ( model, pushUrl_ model.navKey (Url.toString url) )

        LoadUrl url ->
            ( model, Navigation.load url )

        SaveToken token ->
            ( { model | user = User.login token }, Ports.saveToken token )

        SignUp msg mutation ->
            ( model, Api.mutate msg mutation )

        SignIn msg mutation ->
            ( model, Api.mutate msg mutation )

        LoadGlobalFeed msg query ->
            ( model, Api.query msg query )


doBatch : (key -> String -> Cmd msg) -> Model model key -> List (Effect msg) -> ( Model model key, Cmd msg )
doBatch pushUrl_ model effs =
    List.foldl (doNext pushUrl_) ( model, [] ) effs |> Tuple.mapSecond Cmd.batch


doNext : (key -> String -> Cmd msg) -> Effect msg -> ( Model model key, List (Cmd msg) ) -> ( Model model key, List (Cmd msg) )
doNext pushUrl_ eff ( model, cmds ) =
    perform pushUrl_ ( model, eff ) |> Tuple.mapSecond (\cmd -> cmd :: cmds)
