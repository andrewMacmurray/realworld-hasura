module Page exposing
    ( Msg
    , Page
    , changeTo
    , init
    , update
    , view
    )

import Context exposing (Context)
import Effect exposing (Effect)
import Element exposing (..)
import Page.Article as Article
import Page.Author as Author
import Page.Editor as Editor
import Page.Home as Home
import Page.NotFound as NotFound
import Page.Settings as Settings
import Page.SignIn as SignIn
import Page.Signup as SignUp
import Route exposing (Route)
import Url exposing (Url)
import User exposing (User)
import Utils.Update exposing (updateWith, withEffect)



-- Page


type Page
    = Home Home.Model
    | SignUp SignUp.Model
    | SignIn SignIn.Model
    | Editor Editor.Model
    | Settings Settings.Model
    | Article Article.Model
    | Author Author.Model
    | NotFound


type Msg
    = HomeMsg Home.Msg
    | SignUpMsg SignUp.Msg
    | SignInMsg SignIn.Msg
    | EditorMsg Editor.Msg
    | SettingsMsg Settings.Msg
    | ArticleMsg Article.Msg
    | AuthorMsg Author.Msg



-- Init


init : Page
init =
    NotFound


changeTo : Url -> Context -> Page -> ( Page, Effect Msg )
changeTo url context page =
    Route.fromUrl url
        |> Maybe.map (changeTo_ context page)
        |> Maybe.withDefault ( NotFound, Effect.none )
        |> withEffect Effect.closeMenu


changeTo_ : Context -> Page -> Route -> ( Page, Effect Msg )
changeTo_ context page route =
    case route of
        Route.Home tag page_ ->
            updateWith Home HomeMsg (Home.init context.user tag page_)

        Route.SignUp ->
            updateWith SignUp SignUpMsg SignUp.init

        Route.SignIn ->
            updateWith SignIn SignInMsg SignIn.init

        Route.NewArticle ->
            updateWith Editor EditorMsg (Editor.init Editor.NewArticle)

        Route.EditArticle id_ ->
            updateWith Editor EditorMsg (Editor.init (Editor.EditArticle id_))

        Route.Settings ->
            authenticated Settings SettingsMsg Settings.init context.user

        Route.Article id_ ->
            updateWith Article ArticleMsg (Article.init id_)

        Route.Author id_ page_ ->
            updateWith Author AuthorMsg (Author.init id_ page_)

        Route.Logout ->
            ( page, Effect.logout )


authenticated :
    (subModel -> Page)
    -> (subMsg -> msg)
    -> (User.Profile -> ( subModel, Effect subMsg ))
    -> User
    -> ( Page, Effect msg )
authenticated toPage toMsg init_ user =
    case user of
        User.Guest ->
            ( NotFound, Effect.none )

        User.Author profile ->
            init_ profile |> updateWith toPage toMsg



-- Update


update : Msg -> Page -> ( Page, Effect Msg )
update msg page =
    case ( msg, page ) of
        ( HomeMsg msg_, Home model_ ) ->
            Home.update msg_ model_
                |> updateWith Home HomeMsg

        ( SignUpMsg msg_, SignUp model_ ) ->
            SignUp.update msg_ model_
                |> updateWith SignUp SignUpMsg

        ( SignInMsg msg_, SignIn model_ ) ->
            SignIn.update msg_ model_
                |> updateWith SignIn SignInMsg

        ( EditorMsg msg_, Editor model_ ) ->
            Editor.update msg_ model_
                |> updateWith Editor EditorMsg

        ( SettingsMsg msg_, Settings model_ ) ->
            Settings.update msg_ model_
                |> updateWith Settings SettingsMsg

        ( ArticleMsg msg_, Article model_ ) ->
            Article.update msg_ model_
                |> updateWith Article ArticleMsg

        ( AuthorMsg msg_, Author model_ ) ->
            Author.update msg_ model_
                |> updateWith Author AuthorMsg

        ( _, _ ) ->
            ( page, Effect.none )



-- View


view : Context -> Page -> Element Msg
view context model =
    case model of
        Home model_ ->
            Element.map HomeMsg (Home.view context model_)

        SignUp model_ ->
            Element.map SignUpMsg (SignUp.view context model_)

        SignIn model_ ->
            Element.map SignInMsg (SignIn.view context model_)

        Editor model_ ->
            Element.map EditorMsg (whenLoggedIn Editor.view model_ context)

        Settings model_ ->
            Element.map SettingsMsg (whenLoggedIn Settings.view model_ context)

        Article model_ ->
            Element.map ArticleMsg (Article.view context model_)

        Author model_ ->
            Element.map AuthorMsg (Author.view context model_)

        NotFound ->
            NotFound.view context


whenLoggedIn : (User.Profile -> Context -> subModel -> Element msg) -> subModel -> Context -> Element msg
whenLoggedIn view__ subModel context =
    case context.user of
        User.Guest ->
            NotFound.view context

        User.Author profile ->
            view__ profile context subModel
