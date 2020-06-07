module Effect exposing
    ( Effect(..)
    , addToUserFollows
    , batch
    , followAuthor
    , likeArticle
    , loadArticle
    , loadGlobalFeed
    , loadTagFeed
    , loadUrl
    , loadUser
    , loadUserFeed
    , logout
    , map
    , none
    , perform
    , publishArticle
    , pushUrl
    , redirectHome
    , removeFromUserFollows
    , signIn
    , signUp
    , unfollowAuthor
    , unlikeArticle
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
    | AddToUserFollows Int
    | RemoveFromUserFollows Int
    | SignUp (Api.Mutation User.Profile msg)
    | SignIn (Api.Mutation User.Profile msg)
    | LoadGlobalFeed (Api.Query Article.Feed msg)
    | LoadTagFeed (Api.Query Article.Feed msg)
    | LoadUserFeed (Api.Query Article.Feed msg)
    | LoadArticle (Api.Query (Maybe Article) msg)
    | PublishArticle (Api.Mutation () msg)
    | LikeArticle (Api.Mutation Article msg)
    | UnLikeArticle (Api.Mutation Article msg)
    | FollowAuthor (Api.Mutation Int msg)
    | UnfollowAuthor (Api.Mutation Int msg)


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


loadUrl : String -> Effect msg
loadUrl =
    LoadUrl


addToUserFollows : Int -> Effect msg
addToUserFollows =
    AddToUserFollows


removeFromUserFollows : Int -> Effect msg
removeFromUserFollows =
    RemoveFromUserFollows


loadGlobalFeed : Api.Query Article.Feed msg -> Effect msg
loadGlobalFeed =
    LoadGlobalFeed


loadTagFeed : Api.Query Article.Feed msg -> Effect msg
loadTagFeed =
    LoadTagFeed


loadUserFeed : Api.Query Article.Feed msg -> Effect msg
loadUserFeed =
    LoadUserFeed


loadArticle : Api.Query (Maybe Article) msg -> Effect msg
loadArticle =
    LoadArticle


publishArticle : Api.Mutation () msg -> Effect msg
publishArticle =
    PublishArticle


likeArticle : Api.Mutation Article msg -> Effect msg
likeArticle =
    LikeArticle


unlikeArticle : Api.Mutation Article msg -> Effect msg
unlikeArticle =
    UnLikeArticle


followAuthor : Api.Mutation Int msg -> Effect msg
followAuthor =
    FollowAuthor


unfollowAuthor : Api.Mutation Int msg -> Effect msg
unfollowAuthor =
    UnfollowAuthor



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

        LoadGlobalFeed query ->
            LoadGlobalFeed (Api.map toMsg query)

        LoadTagFeed query ->
            LoadTagFeed (Api.map toMsg query)

        LoadUserFeed query ->
            LoadUserFeed (Api.map toMsg query)

        LoadArticle query ->
            LoadArticle (Api.map toMsg query)

        PublishArticle mut ->
            PublishArticle (Api.map toMsg mut)

        LikeArticle mut ->
            LikeArticle (Api.map toMsg mut)

        UnLikeArticle mut ->
            UnLikeArticle (Api.map toMsg mut)

        FollowAuthor mut ->
            FollowAuthor (Api.map toMsg mut)

        UnfollowAuthor mut ->
            UnfollowAuthor (Api.map toMsg mut)



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
                , Route.Home Nothing |> Route.routeToString |> pushUrl_ model.navKey
                ]
            )

        AddToUserFollows following_id ->
            { model | user = User.addFollowingId following_id model.user } |> andThenCacheUser

        RemoveFromUserFollows following_id ->
            { model | user = User.removeFollowingId following_id model.user } |> andThenCacheUser

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

        LoadUserFeed query ->
            ( model, Api.doQuery model.user query )

        LoadTagFeed query ->
            ( model, Api.doQuery model.user query )

        LoadArticle query ->
            ( model, Api.doQuery model.user query )

        PublishArticle mutation ->
            ( model, Api.doMutation model.user mutation )

        LikeArticle mutation ->
            ( model, Api.doMutation model.user mutation )

        UnLikeArticle mutation ->
            ( model, Api.doMutation model.user mutation )

        FollowAuthor mutation ->
            ( model, Api.doMutation model.user mutation )

        UnfollowAuthor mutation ->
            ( model, Api.doMutation model.user mutation )


andThenCacheUser : Model model key -> ( Model model key, Cmd msg )
andThenCacheUser =
    andThenDo cacheUser


cacheUser : Model model key -> Cmd msg
cacheUser =
    .user
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
