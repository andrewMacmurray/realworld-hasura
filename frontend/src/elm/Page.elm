module Page exposing
    ( Msg
    , Page
    , init
    , update
    , view
    )

import Effect exposing (Effect)
import Element exposing (..)
import Page.Home as Home
import Page.NewPost as NewPost
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
    | NewPost NewPost.Model
    | Settings Settings.Model
    | NotFound


type Msg
    = HomeMsg Home.Msg
    | SignUpMsg SignUp.Msg
    | SignInMsg SignIn.Msg
    | NewPostMsg NewPost.Msg
    | SettingsMsg Settings.Msg



-- Init


init : User -> Url -> ( Page, Effect Msg )
init user url =
    case Route.fromUrl url of
        Just Route.Home ->
            updateWith Home HomeMsg Home.init

        Just Route.SignUp ->
            updateWith SignUp SignUpMsg SignUp.init

        Just Route.SignIn ->
            updateWith SignIn SignInMsg SignIn.init

        Just Route.NewPost ->
            updateWith NewPost NewPostMsg NewPost.init

        Just Route.Settings ->
            initAuthenticated Settings SettingsMsg Settings.init user

        Nothing ->
            ( NotFound, Effect.none )


initAuthenticated modelF msgF init_ user =
    case user of
        User.Guest ->
            ( NotFound, Effect.none )

        User.LoggedIn profile ->
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

        ( NewPostMsg msg_, NewPost model_ ) ->
            NewPost.update msg_ model_
                |> updateWith NewPost NewPostMsg

        ( SettingsMsg msg_, Settings model_ ) ->
            Settings.update msg_ model_
                |> updateWith Settings SettingsMsg

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

        NewPost model_ ->
            Element.map NewPostMsg (viewAuthenticated NewPost.view model_ user)

        Settings model_ ->
            Element.map SettingsMsg (viewAuthenticated Settings.view model_ user)

        NotFound ->
            NotFound.view


viewAuthenticated : (User.Profile -> subModel -> Element msg) -> subModel -> User -> Element msg
viewAuthenticated view__ subModel user =
    case user of
        User.Guest ->
            NotFound.view

        User.LoggedIn profile ->
            view__ profile subModel