module Effect exposing
    ( Effect(..)
    , batch
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
import Browser.Navigation as Navigation
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet exposing (SelectionSet)
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


none : Effect msg
none =
    None


batch : List (Effect msg) -> Effect msg
batch =
    Batch


saveToken : String -> Effect msg
saveToken =
    SaveToken


signUp : (Api.Response String -> msg) -> SelectionSet String RootMutation -> Effect msg
signUp =
    SignUp


signIn : (Api.Response String -> msg) -> SelectionSet String RootMutation -> Effect msg
signIn =
    SignIn


pushUrl : Url -> Effect msg
pushUrl =
    PushUrl


navigateTo : Route -> Effect msg
navigateTo =
    NavigateTo


loadUrl : String -> Effect msg
loadUrl =
    LoadUrl



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

        SignUp msg res ->
            SignUp (msg >> toMsg) res

        SignIn msg res ->
            SignIn (msg >> toMsg) res

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url



-- Perform


type alias Model model =
    { model
        | navKey : Navigation.Key
        , user : User
    }


perform : ( Model model, Effect msg ) -> ( Model model, Cmd msg )
perform ( model, effect ) =
    case effect of
        None ->
            ( model, Cmd.none )

        Batch effs ->
            List.foldl nextEff ( model, [] ) effs |> Tuple.mapSecond Cmd.batch

        NavigateTo route ->
            ( model, Navigation.pushUrl model.navKey (Route.routeToString route) )

        PushUrl url ->
            ( model, Navigation.pushUrl model.navKey (Url.toString url) )

        LoadUrl url ->
            ( model, Navigation.load url )

        SaveToken token ->
            ( { model | user = User.login token }, Cmd.none )

        SignUp msg mutation ->
            ( model, Api.mutate msg mutation )

        SignIn msg mutation ->
            ( model, Api.mutate msg mutation )


nextEff eff ( model, cmds ) =
    perform ( model, eff ) |> Tuple.mapSecond (\c -> c :: cmds)
