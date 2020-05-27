module Effect exposing
    ( Effect(..)
    , loadUrl
    , map
    , navigateTo
    , none
    , perform
    , pushUrl
    , signup
    )

import Api
import Browser.Navigation as Navigation
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet exposing (SelectionSet)
import Route exposing (Route)
import Url exposing (Url)


type Effect msg
    = None
    | PushUrl Url
    | NavigateTo Route
    | LoadUrl String
    | Signup (Api.Response String -> msg) (SelectionSet String RootMutation)


none : Effect msg
none =
    None


signup =
    Signup


pushUrl =
    PushUrl


navigateTo =
    NavigateTo


loadUrl =
    LoadUrl


map : (a -> msg) -> Effect a -> Effect msg
map toMsg effect =
    case effect of
        None ->
            None

        NavigateTo route ->
            NavigateTo route

        Signup msg res ->
            Signup (msg >> toMsg) res

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url


perform : Navigation.Key -> Effect msg -> Cmd msg
perform navKey effect =
    case effect of
        None ->
            Cmd.none

        NavigateTo route ->
            Navigation.pushUrl navKey (Route.routeToString route)

        PushUrl url ->
            Navigation.pushUrl navKey (Url.toString url)

        LoadUrl url ->
            Navigation.load url

        Signup msg mutation ->
            Api.mutate msg mutation
