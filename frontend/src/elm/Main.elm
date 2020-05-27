module Main exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , main
    , update
    , view
    )

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
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



-- Program


main : Program Flags (Model Nav.Key) Msg
main =
    Browser.application
        { init = performInit
        , update = performUpdate
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }



-- Model


type alias Model key =
    { page : Page
    , user : User
    , navKey : key
    }


type Page
    = Home Home.Model
    | SignUp SignUp.Model
    | SignIn SignIn.Model
    | NewPost NewPost.Model
    | NotFound


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | HomeMsg Home.Msg
    | SignUpMsg SignUp.Msg
    | SignInMsg SignIn.Msg
    | NewPostMsg NewPost.Msg


type alias Flags =
    { token : Maybe String
    }



-- Init


performInit : Flags -> Url -> Nav.Key -> ( Model Nav.Key, Cmd Msg )
performInit flags url key =
    Effect.perform (init flags url key)


init : Flags -> Url -> key -> ( Model key, Effect Msg )
init flags url key =
    initialModel flags key |> changePageTo url


initialModel : Flags -> key -> Model key
initialModel flags key =
    { page = NotFound
    , user = User.fromToken flags.token
    , navKey = key
    }



-- Update


performUpdate : Msg -> Model Nav.Key -> ( Model Nav.Key, Cmd Msg )
performUpdate msg model =
    Effect.perform (update msg model)


update : Msg -> Model key -> ( Model key, Effect Msg )
update msg model =
    case ( msg, model.page ) of
        ( UrlRequest urlRequest, _ ) ->
            handleUrl model urlRequest

        ( UrlChange url, _ ) ->
            changePageTo url model

        ( HomeMsg msg_, Home model_ ) ->
            Home.update msg_ model_
                |> updateWith Home HomeMsg model

        ( SignUpMsg msg_, SignUp model_ ) ->
            SignUp.update msg_ model_
                |> updateWith SignUp SignUpMsg model

        ( SignInMsg msg_, SignIn model_ ) ->
            SignIn.update msg_ model_
                |> updateWith SignIn SignInMsg model

        ( NewPostMsg msg_, NewPost model_ ) ->
            NewPost.update msg_ model_
                |> updateWith NewPost NewPostMsg model

        ( _, _ ) ->
            ( model, Effect.none )


handleUrl : Model key -> UrlRequest -> ( Model key, Effect Msg )
handleUrl model request =
    case request of
        Browser.Internal url ->
            ( model, Effect.pushUrl url )

        Browser.External url ->
            ( model, Effect.loadUrl url )


updateWith :
    (pageModel -> page)
    -> (pageMsg -> msg)
    -> { model | page : page }
    -> ( pageModel, Effect pageMsg )
    -> ( { model | page : page }, Effect msg )
updateWith modelF msgF model ( m, c ) =
    ( { model | page = modelF m }
    , Effect.map msgF c
    )


changePageTo : Url -> Model key -> ( Model key, Effect Msg )
changePageTo url model =
    case Route.fromUrl url of
        Just Route.Home ->
            Home.init |> updateWith Home HomeMsg model

        Just Route.SignUp ->
            SignUp.init |> updateWith SignUp SignUpMsg model

        Just Route.SignIn ->
            SignIn.init |> updateWith SignIn SignInMsg model

        Just Route.NewPost ->
            NewPost.init |> updateWith NewPost NewPostMsg model

        Nothing ->
            ( { model | page = NotFound }, Effect.none )



-- Subscriptions


subscriptions : Model key -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model key -> Document Msg
view model =
    { title = "Conduit"
    , body = [ layout [] (view_ model) ]
    }


view_ : Model key -> Element Msg
view_ model =
    case model.page of
        Home model_ ->
            Element.map HomeMsg (Home.view model.user model_)

        SignUp model_ ->
            Element.map SignUpMsg (SignUp.view model_)

        SignIn model_ ->
            Element.map SignInMsg (SignIn.view model_)

        NewPost model_ ->
            Element.map NewPostMsg (authenticated NewPost.view model_ model.user)

        NotFound ->
            NotFound.view


authenticated viewF subModel user =
    case user of
        User.Guest ->
            NotFound.view

        User.LoggedIn profile ->
            viewF profile subModel
