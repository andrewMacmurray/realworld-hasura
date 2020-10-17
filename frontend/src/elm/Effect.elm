module Effect exposing
    ( Effect(..)
    , addToUserFollows
    , batch
    , closeMenu
    , deleteArticle
    , deleteComment
    , editArticle
    , followAuthor
    , getViewport
    , goToArticle
    , likeArticle
    , loadArticle
    , loadAuthorFeed
    , loadFeed
    , loadHomeFeed
    , loadUrl
    , loadUser
    , logout
    , map
    , mutateSettings
    , none
    , perform
    , postComment
    , publishArticle
    , pushUrl
    , redirectHome
    , refreshUser
    , removeFromUserFollows
    , setOffsetY
    , signIn
    , signUp
    , unfollowAuthor
    , unlikeArticle
    , updateComment
    , updateSettings
    , updateUser
    )

import Api
import Article exposing (Article)
import Article.Feed as Feed exposing (Feed)
import Browser.Dom as Dom exposing (Viewport)
import Browser.Navigation as Navigation
import Context exposing (Context)
import Ports
import Route exposing (Route)
import Route.Effect
import Task
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
    | GetViewport (Viewport -> msg)
    | SetOffsetY msg Float
    | Logout
    | AddToUserFollows Int
    | RemoveFromUserFollows Int
    | CloseMenu
    | SignUp (Api.Mutation User.Profile msg)
    | SignIn (Api.Mutation User.Profile msg)
    | LoadHomeFeed (Api.Query Feed.Home msg)
    | LoadFeed (Api.Query Feed msg)
    | LoadArticle (Api.Query (Maybe Article) msg)
    | RefreshUser (Api.Query User msg)
    | MutateWithEmptyResponse (Api.Mutation () msg)
    | MutationReturningArticle (Api.Mutation Article msg)
    | MutationReturningArticleId (Api.Mutation Article.Id msg)
    | MutateAuthor (Api.Mutation Int msg)
    | LoadAuthorFeed (Api.Query (Maybe Feed.ForAuthor) msg)
    | MutateSettings (Api.Mutation () msg)
    | UpdateSettings User.SettingsUpdate
    | UpdateUser (Api.Response User)


none : Effect msg
none =
    None


batch : List (Effect msg) -> Effect msg
batch =
    Batch


getViewport : (Viewport -> msg) -> Effect msg
getViewport =
    GetViewport


setOffsetY : msg -> Viewport -> Effect msg
setOffsetY msg vp =
    SetOffsetY msg vp.viewport.y


loadUser : User.Profile -> Effect msg
loadUser =
    LoadUser


logout : Effect msg
logout =
    Logout


signUp : Api.Mutation User.Profile msg -> Effect msg
signUp =
    SignUp


signIn : Api.Mutation User.Profile msg -> Effect msg
signIn =
    SignIn


pushUrl : Url -> Effect msg
pushUrl =
    PushUrl


redirectHome : Effect msg
redirectHome =
    NavigateTo Route.home


goToArticle : Article.Id -> Effect msg
goToArticle =
    NavigateTo << Route.Article


loadUrl : String -> Effect msg
loadUrl =
    LoadUrl


addToUserFollows : Int -> Effect msg
addToUserFollows =
    AddToUserFollows


removeFromUserFollows : Int -> Effect msg
removeFromUserFollows =
    RemoveFromUserFollows


closeMenu : Effect msg
closeMenu =
    CloseMenu


refreshUser : Api.Query User msg -> Effect msg
refreshUser =
    RefreshUser


loadHomeFeed : Api.Query Feed.Home msg -> Effect msg
loadHomeFeed =
    LoadHomeFeed


loadArticle : Api.Query (Maybe Article) msg -> Effect msg
loadArticle =
    LoadArticle


loadFeed : Api.Query Feed msg -> Effect msg
loadFeed =
    LoadFeed


publishArticle : Api.Mutation Article.Id msg -> Effect msg
publishArticle =
    MutationReturningArticleId


editArticle : Api.Mutation Article.Id msg -> Effect msg
editArticle =
    MutationReturningArticleId


deleteArticle : Api.Mutation () msg -> Effect msg
deleteArticle =
    MutateWithEmptyResponse


likeArticle : Api.Mutation Article msg -> Effect msg
likeArticle =
    MutationReturningArticle


unlikeArticle : Api.Mutation Article msg -> Effect msg
unlikeArticle =
    MutationReturningArticle


postComment : Api.Mutation Article msg -> Effect msg
postComment =
    MutationReturningArticle


deleteComment : Api.Mutation Article msg -> Effect msg
deleteComment =
    MutationReturningArticle


updateComment : Api.Mutation Article msg -> Effect msg
updateComment =
    MutationReturningArticle


followAuthor : Api.Mutation Int msg -> Effect msg
followAuthor =
    MutateAuthor


unfollowAuthor : Api.Mutation Int msg -> Effect msg
unfollowAuthor =
    MutateAuthor


loadAuthorFeed : Api.Query (Maybe Feed.ForAuthor) msg -> Effect msg
loadAuthorFeed =
    LoadAuthorFeed


mutateSettings : Api.Mutation () msg -> Effect msg
mutateSettings =
    MutateSettings


updateSettings : User.SettingsUpdate -> Effect msg
updateSettings =
    UpdateSettings


updateUser : Api.Response User -> Effect msg
updateUser =
    UpdateUser



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

        GetViewport msg ->
            GetViewport (msg >> toMsg)

        SetOffsetY msg vp ->
            SetOffsetY (toMsg msg) vp

        Logout ->
            Logout

        SignUp req ->
            SignUp (Api.map toMsg req)

        SignIn req ->
            SignIn (Api.map toMsg req)

        PushUrl url ->
            PushUrl url

        LoadUrl url ->
            LoadUrl url

        AddToUserFollows id ->
            AddToUserFollows id

        RemoveFromUserFollows id ->
            RemoveFromUserFollows id

        CloseMenu ->
            CloseMenu

        LoadHomeFeed req ->
            LoadHomeFeed (Api.map toMsg req)

        LoadArticle req ->
            LoadArticle (Api.map toMsg req)

        LoadFeed req ->
            LoadFeed (Api.map toMsg req)

        RefreshUser req ->
            RefreshUser (Api.map toMsg req)

        MutateWithEmptyResponse req ->
            MutateWithEmptyResponse (Api.map toMsg req)

        MutationReturningArticle req ->
            MutationReturningArticle (Api.map toMsg req)

        MutationReturningArticleId req ->
            MutationReturningArticleId (Api.map toMsg req)

        MutateAuthor req ->
            MutateAuthor (Api.map toMsg req)

        LoadAuthorFeed req ->
            LoadAuthorFeed (Api.map toMsg req)

        MutateSettings req ->
            MutateSettings (Api.map toMsg req)

        UpdateSettings settings ->
            UpdateSettings settings

        UpdateUser details ->
            UpdateUser details



-- Perform


type alias Model model key =
    { model | navKey : key, context : Context }


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

        GetViewport msg ->
            ( model, Task.perform msg Dom.getViewport )

        SetOffsetY msg y ->
            ( model, Task.perform (always msg) (Dom.setViewport 0 y) )

        Logout ->
            ( { model | context = Context.setUser User.Guest model.context }
            , Cmd.batch
                [ Ports.logout
                , Route.home |> Route.routeToString |> pushUrl_ model.navKey
                ]
            )

        AddToUserFollows following_id ->
            andThenCacheUser { model | context = Context.updateUser (User.addFollowingId following_id) model.context }

        RemoveFromUserFollows following_id ->
            andThenCacheUser { model | context = Context.updateUser (User.removeFollowingId following_id) model.context }

        CloseMenu ->
            ( { model | context = Context.closeMenu model.context }, Cmd.none )

        PushUrl url ->
            case Route.Effect.fromUrl url of
                Just eff ->
                    ( handleRouteEffect model eff, Cmd.none )

                Nothing ->
                    ( model, pushUrl_ model.navKey (Url.toString url) )

        LoadUrl url ->
            ( model, Navigation.load url )

        LoadUser user ->
            ( { model | context = Context.setUser (User.Author user) model.context }
            , Ports.toUser user |> Ports.saveUser
            )

        RefreshUser query ->
            ( model, Api.doQuery model.context.user query )

        SignUp mutation ->
            ( model, Api.doMutation model.context.user mutation )

        SignIn mutation ->
            ( model, Api.doMutation model.context.user mutation )

        LoadHomeFeed query ->
            ( model, Api.doQuery model.context.user query )

        LoadArticle query ->
            ( model, Api.doQuery model.context.user query )

        LoadFeed query ->
            ( model, Api.doQuery model.context.user query )

        MutateWithEmptyResponse mutation ->
            ( model, Api.doMutation model.context.user mutation )

        MutationReturningArticle mutation ->
            ( model, Api.doMutation model.context.user mutation )

        MutationReturningArticleId mutation ->
            ( model, Api.doMutation model.context.user mutation )

        MutateAuthor mutation ->
            ( model, Api.doMutation model.context.user mutation )

        LoadAuthorFeed query ->
            ( model, Api.doQuery model.context.user query )

        MutateSettings mutation ->
            ( model, Api.doMutation model.context.user mutation )

        UpdateSettings settings ->
            andThenCacheUser { model | context = Context.updateUser (User.updateSettings settings) model.context }

        UpdateUser response ->
            handleUpdateUser model response


handleRouteEffect : Model model key -> Route.Effect.Route -> Model model key
handleRouteEffect model route =
    case route of
        Route.Effect.OpenMenu ->
            { model | context = Context.openMenu model.context }

        Route.Effect.CloseMenu ->
            { model | context = Context.closeMenu model.context }


andThenCacheUser : Model model key -> ( Model model key, Cmd msg )
andThenCacheUser =
    andThenDo cacheUser


cacheUser : Model model key -> Cmd msg
cacheUser model =
    model.context.user
        |> User.getProfile
        |> Maybe.map (Ports.toUser >> Ports.saveUser)
        |> Maybe.withDefault Cmd.none


handleUpdateUser : Model model key -> Api.Response User -> ( Model model key, Cmd msg )
handleUpdateUser model response =
    case response of
        Ok user ->
            andThenCacheUser { model | context = Context.setUser user model.context }

        Err _ ->
            ( model, Cmd.none )


andThenDo : (b -> a) -> b -> ( b, a )
andThenDo cmd model =
    ( model, cmd model )


doBatch : PushUrl key msg -> Model model key -> List (Effect msg) -> ( Model model key, Cmd msg )
doBatch pushUrl_ model effs =
    List.foldl (doNext pushUrl_) ( model, [] ) effs |> Tuple.mapSecond Cmd.batch


doNext : PushUrl key msg -> Effect msg -> ( Model model key, List (Cmd msg) ) -> ( Model model key, List (Cmd msg) )
doNext pushUrl_ eff ( model, cmds ) =
    perform pushUrl_ ( model, eff ) |> Tuple.mapSecond (\cmd -> cmd :: cmds)
