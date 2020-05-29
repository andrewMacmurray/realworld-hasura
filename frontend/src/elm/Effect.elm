module Effect exposing
    ( Effect(..)
    , batch
    , loadArticle
    , loadGlobalFeed
    , loadUrl
    , loadUser
    , logout
    , map
    , navigateTo
    , none
    , perform
    , publishArticle
    , pushUrl
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
    | LoadUser User.Profile
    | Logout
    | SignUp (Api.Mutation User.Profile msg)
    | SignIn (Api.Mutation User.Profile msg)
    | LoadGlobalFeed (Api.Query (List Article) msg)
    | LoadArticle (Api.Query (Maybe Article) msg)
    | PublishArticle (Api.Mutation () msg)


none =
    None


batch =
    Batch


loadUser =
    LoadUser


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


loadArticle =
    LoadArticle


publishArticle =
    PublishArticle



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

        LoadUser token ->
            LoadUser token

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

        LoadArticle query ->
            LoadArticle (Api.map toMsg query)

        PublishArticle mut ->
            PublishArticle (Api.map toMsg mut)



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

        LoadUser user ->
            ( { model | user = User.LoggedIn user }
            , Ports.toUser user |> Ports.saveUser
            )

        SignUp mutation ->
            ( model, Api.doMutation model.user mutation )

        SignIn mutation ->
            ( model, Api.doMutation model.user mutation )

        LoadGlobalFeed query ->
            ( model, Api.doQuery model.user query )

        LoadArticle query ->
            ( model, Api.doQuery model.user query )

        PublishArticle mutation ->
            ( model, Api.doMutation model.user mutation )


doBatch : PushUrl key msg -> Model model key -> List (Effect msg) -> ( Model model key, Cmd msg )
doBatch pushUrl_ model effs =
    List.foldl (doNext pushUrl_) ( model, [] ) effs |> Tuple.mapSecond Cmd.batch


doNext : PushUrl key msg -> Effect msg -> ( Model model key, List (Cmd msg) ) -> ( Model model key, List (Cmd msg) )
doNext pushUrl_ eff ( model, cmds ) =
    perform pushUrl_ ( model, eff ) |> Tuple.mapSecond (\cmd -> cmd :: cmds)
