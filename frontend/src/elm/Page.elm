module Page exposing
    ( Msg
    , Page
    , changeTo
    , init
    , update
    , view
    )

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
import Route
import Url exposing (Url)
import User exposing (User)
import Utils.Update exposing (updateWith)



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


changeTo : Url -> User -> Page -> ( Page, Effect Msg )
changeTo url user page =
    case Route.fromUrl url of
        Just (Route.Home tag) ->
            updateWith Home HomeMsg (Home.init user tag)

        Just Route.SignUp ->
            updateWith SignUp SignUpMsg SignUp.init

        Just Route.SignIn ->
            updateWith SignIn SignInMsg SignIn.init

        Just Route.NewArticle ->
            updateWith Editor EditorMsg (Editor.init Editor.New)

        Just (Route.EditArticle id_) ->
            updateWith Editor EditorMsg (Editor.init (Editor.Edit id_))

        Just Route.Settings ->
            initAuthenticated Settings SettingsMsg Settings.init user

        Just (Route.Article id_) ->
            updateWith Article ArticleMsg (Article.init id_)

        Just (Route.Author id_) ->
            updateWith Author AuthorMsg (Author.init id_)

        Just Route.Logout ->
            ( page, Effect.logout )

        Nothing ->
            ( NotFound, Effect.none )


initAuthenticated modelF msgF init_ user =
    case user of
        User.Guest ->
            ( NotFound, Effect.none )

        User.Author profile ->
            init_ profile |> updateWith modelF msgF



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


view : User -> Page -> Element Msg
view user model =
    case model of
        Home model_ ->
            Element.map HomeMsg (Home.view user model_)

        SignUp model_ ->
            Element.map SignUpMsg (SignUp.view model_)

        SignIn model_ ->
            Element.map SignInMsg (SignIn.view model_)

        Editor model_ ->
            Element.map EditorMsg (whenLoggedIn Editor.view model_ user)

        Settings model_ ->
            Element.map SettingsMsg (whenLoggedIn Settings.view model_ user)

        Article model_ ->
            Element.map ArticleMsg (Article.view user model_)

        Author model_ ->
            Element.map AuthorMsg (Author.view user model_)

        NotFound ->
            NotFound.view


whenLoggedIn : (User.Profile -> subModel -> Element msg) -> subModel -> User -> Element msg
whenLoggedIn view__ subModel user =
    case user of
        User.Guest ->
            NotFound.view

        User.Author profile ->
            view__ profile subModel
