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
    | NotFound


type Msg
    = HomeMsg Home.Msg
    | SignUpMsg SignUp.Msg
    | SignInMsg SignIn.Msg
    | NewPostMsg NewPost.Msg



-- Init


init : Url -> ( Page, Effect Msg )
init url =
    case Route.fromUrl url of
        Just Route.Home ->
            Home.init |> updateWith Home HomeMsg

        Just Route.SignUp ->
            SignUp.init |> updateWith SignUp SignUpMsg

        Just Route.SignIn ->
            SignIn.init |> updateWith SignIn SignInMsg

        Just Route.NewPost ->
            NewPost.init |> updateWith NewPost NewPostMsg

        Nothing ->
            ( NotFound, Effect.none )



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

        NotFound ->
            NotFound.view


viewAuthenticated : (User.Profile -> subModel -> Element msg) -> subModel -> User -> Element msg
viewAuthenticated view__ subModel user =
    case user of
        User.Guest ->
            NotFound.view

        User.LoggedIn profile ->
            view__ profile subModel
