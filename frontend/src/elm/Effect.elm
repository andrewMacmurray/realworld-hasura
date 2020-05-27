module Effect exposing
    ( Effect(..)
    , applyUpdate
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


type alias Model model =
    { model
        | navKey : Navigation.Key
        , user : User
    }


perform : ( Model model, Effect msg ) -> ( Model model, Cmd msg )
perform ( model, effect ) =
    applyUpdate ( model, effect ) |> Tuple.mapSecond (toCmd model.navKey)


applyUpdate : ( { m | user : User }, Effect msg ) -> ( { m | user : User }, Effect msg )
applyUpdate ( model, effect ) =
    case effect of
        Batch effs ->
            ( batchApply model effs, effect )

        SaveToken token ->
            ( { model | user = User.login token }, effect )

        _ ->
            ( model, effect )


batchApply : { m | user : User } -> List (Effect msg) -> { m | user : User }
batchApply model effs =
    let
        next eff ( nextModel, _ ) =
            applyUpdate ( nextModel, eff )
    in
    List.foldl next ( model, none ) effs |> Tuple.first



-- To Cmd


toCmd : Navigation.Key -> Effect msg -> Cmd msg
toCmd navKey effect =
    case effect of
        None ->
            Cmd.none

        Batch effs ->
            Cmd.batch (List.map (toCmd navKey) effs)

        NavigateTo route ->
            Navigation.pushUrl navKey (Route.routeToString route)

        PushUrl url ->
            Navigation.pushUrl navKey (Url.toString url)

        LoadUrl url ->
            Navigation.load url

        SaveToken token ->
            Ports.saveToken token

        SignUp msg mutation ->
            Api.mutate msg mutation

        SignIn msg mutation ->
            Api.mutate msg mutation

        LoadGlobalFeed msg query ->
            Api.query msg query
