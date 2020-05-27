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



-- Effect


type Effect msg
    = None
    | PushUrl Url
    | NavigateTo Route
    | LoadUrl String
    | Signup (Api.Response String -> msg) (SelectionSet String RootMutation)


none : Effect msg
none =
    None


signup : (Api.Response String -> msg) -> SelectionSet String RootMutation -> Effect msg
signup =
    Signup


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

        NavigateTo route ->
            NavigateTo route

        Signup msg res ->
            Signup (msg >> toMsg) res

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url



-- Perform


perform : Navigation.Key -> ( model, Effect msg ) -> ( model, Cmd msg )
perform =
    perform_ >> Tuple.mapSecond


perform_ : Navigation.Key -> Effect msg -> Cmd msg
perform_ navKey effect =
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
