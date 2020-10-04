module Effect exposing
    ( Effect(..)
    , addToUserFollows
    , batch
    , deleteArticle
    , deleteComment
    , editArticle
    , followAuthor
    , goToArticle
    , likeArticle
    , loadArticle
    , loadArticles
    , loadAuthorFeed
    , loadFeed
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
    , removeFromUserFollows
    , signIn
    , signUp
    , unfollowAuthor
    , unlikeArticle
    , updateComment
    , updateSettings
    )

import Api
import Article exposing (Article)
import Article.Author.Feed as Author
import Browser.Navigation as Navigation
import Context exposing (Context)
import Ports
import Route exposing (Route)
import Route.Effect
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
    | AddToUserFollows Int
    | RemoveFromUserFollows Int
    | SignUp (Api.Mutation User.Profile msg)
    | SignIn (Api.Mutation User.Profile msg)
    | LoadArticleFeed (Api.Query Article.Feed msg)
    | LoadArticles (Api.Query (List Article) msg)
    | LoadArticle (Api.Query (Maybe Article) msg)
    | MutateWithEmptyResponse (Api.Mutation () msg)
    | MutationReturningArticle (Api.Mutation Article msg)
    | MutateAuthor (Api.Mutation Int msg)
    | LoadAuthorFeed (Api.Query (Maybe Author.Feed) msg)
    | MutateSettings (Api.Mutation () msg)
    | UpdateSettings User.SettingsUpdate


none : Effect msg
none =
    None


batch : List (Effect msg) -> Effect msg
batch =
    Batch


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
    NavigateTo (Route.Home Nothing)


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


loadFeed : Api.Query Article.Feed msg -> Effect msg
loadFeed =
    LoadArticleFeed


loadArticle : Api.Query (Maybe Article) msg -> Effect msg
loadArticle =
    LoadArticle


loadArticles : Api.Query (List Article) msg -> Effect msg
loadArticles =
    LoadArticles


publishArticle : Api.Mutation () msg -> Effect msg
publishArticle =
    MutateWithEmptyResponse


editArticle : Api.Mutation () msg -> Effect msg
editArticle =
    MutateWithEmptyResponse


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


loadAuthorFeed : Api.Query (Maybe Author.Feed) msg -> Effect msg
loadAuthorFeed =
    LoadAuthorFeed


mutateSettings : Api.Mutation () msg -> Effect msg
mutateSettings =
    MutateSettings


updateSettings : User.SettingsUpdate -> Effect msg
updateSettings =
    UpdateSettings



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

        AddToUserFollows id ->
            AddToUserFollows id

        RemoveFromUserFollows id ->
            RemoveFromUserFollows id

        LoadArticleFeed query ->
            LoadArticleFeed (Api.map toMsg query)

        LoadArticle query ->
            LoadArticle (Api.map toMsg query)

        LoadArticles query ->
            LoadArticles (Api.map toMsg query)

        MutateWithEmptyResponse mut ->
            MutateWithEmptyResponse (Api.map toMsg mut)

        MutationReturningArticle mut ->
            MutationReturningArticle (Api.map toMsg mut)

        MutateAuthor mut ->
            MutateAuthor (Api.map toMsg mut)

        LoadAuthorFeed query ->
            LoadAuthorFeed (Api.map toMsg query)

        MutateSettings mut ->
            MutateSettings (Api.map toMsg mut)

        UpdateSettings settings ->
            UpdateSettings settings



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

        Logout ->
            ( { model | context = Context.setUser User.Guest model.context }
            , Cmd.batch
                [ Ports.logout
                , Route.Home Nothing |> Route.routeToString |> pushUrl_ model.navKey
                ]
            )

        AddToUserFollows following_id ->
            andThenCacheUser { model | context = Context.updateUser (User.addFollowingId following_id) model.context }

        RemoveFromUserFollows following_id ->
            andThenCacheUser { model | context = Context.updateUser (User.removeFollowingId following_id) model.context }

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

        SignUp mutation ->
            ( model, Api.doMutation model.context.user mutation )

        SignIn mutation ->
            ( model, Api.doMutation model.context.user mutation )

        LoadArticleFeed query ->
            ( model, Api.doQuery model.context.user query )

        LoadArticle query ->
            ( model, Api.doQuery model.context.user query )

        LoadArticles query ->
            ( model, Api.doQuery model.context.user query )

        MutateWithEmptyResponse mutation ->
            ( model, Api.doMutation model.context.user mutation )

        MutationReturningArticle mutation ->
            ( model, Api.doMutation model.context.user mutation )

        MutateAuthor mutation ->
            ( model, Api.doMutation model.context.user mutation )

        LoadAuthorFeed query ->
            ( model, Api.doQuery model.context.user query )

        MutateSettings mutation ->
            ( model, Api.doMutation model.context.user mutation )

        UpdateSettings settings ->
            andThenCacheUser { model | context = Context.updateUser (User.updateSettings settings) model.context }


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
cacheUser =
    .context
        >> .user
        >> User.getProfile
        >> Maybe.map (Ports.toUser >> Ports.saveUser)
        >> Maybe.withDefault Cmd.none


andThenDo : (b -> a) -> b -> ( b, a )
andThenDo cmd model =
    ( model, cmd model )


doBatch : PushUrl key msg -> Model model key -> List (Effect msg) -> ( Model model key, Cmd msg )
doBatch pushUrl_ model effs =
    List.foldl (doNext pushUrl_) ( model, [] ) effs |> Tuple.mapSecond Cmd.batch


doNext : PushUrl key msg -> Effect msg -> ( Model model key, List (Cmd msg) ) -> ( Model model key, List (Cmd msg) )
doNext pushUrl_ eff ( model, cmds ) =
    perform pushUrl_ ( model, eff ) |> Tuple.mapSecond (\cmd -> cmd :: cmds)
