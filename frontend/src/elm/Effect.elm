module Effect exposing
    ( Effect(..)
    , batch
    , loadGlobalFeed
    , loadUrl
    , logout
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
    | Logout
    | SignUp (Api.Mutation String msg)
    | SignIn (Api.Mutation String msg)
    | LoadGlobalFeed (Api.Query (List Article) msg)


none =
    None


batch =
    Batch


saveToken =
    SaveToken


logout =
    Logout


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

        Logout ->
            Logout

        SignUp mut ->
            SignUp (Api.map toMsg mut)

        SignIn mut ->
            SignIn (Api.map toMsg mut)

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url

        LoadGlobalFeed query ->
            LoadGlobalFeed (Api.map toMsg query)



-- Perform


type alias Model model key =
    { model | user : User, navKey : key }


type alias PushUrl key msg =
    key -> String -> Cmd msg


perform : PushUrl key msg -> ( Model model key, Effect msg ) -> ( Model model key, Cmd msg )
perform pushUrl_ ( model, effect ) =
    case effect of
        None ->
            ( model, Cmd.none )

        Batch effs ->
            doBatch pushUrl_ model effs

        NavigateTo route ->
            ( model, pushUrl_ model.navKey (Route.routeToString route) )

        Logout ->
            ( { model | user = User.Guest }
            , Cmd.batch
                [ Ports.logout
                , pushUrl_ model.navKey (Route.routeToString Route.Home)
                ]
            )

        PushUrl url ->
            ( model, pushUrl_ model.navKey (Url.toString url) )

        LoadUrl url ->
            ( model, Navigation.load url )

        SaveToken token ->
            ( { model | user = User.login token }, Ports.saveToken token )

        SignUp mutation ->
            ( model, Api.mutationRequest mutation )

        SignIn mutation ->
            ( model, Api.mutationRequest mutation )

        LoadGlobalFeed query ->
            ( model, Api.queryRequest query )


doBatch : PushUrl key msg -> Model model key -> List (Effect msg) -> ( Model model key, Cmd msg )
doBatch pushUrl_ model effs =
    List.foldl (doNext pushUrl_) ( model, [] ) effs |> Tuple.mapSecond Cmd.batch


doNext : PushUrl key msg -> Effect msg -> ( Model model key, List (Cmd msg) ) -> ( Model model key, List (Cmd msg) )
doNext pushUrl_ eff ( model, cmds ) =
    perform pushUrl_ ( model, eff ) |> Tuple.mapSecond (\cmd -> cmd :: cmds)
