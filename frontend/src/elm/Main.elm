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
    | NotFound


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | HomeMsg Home.Msg
    | SignUpMsg SignUp.Msg
    | SignInMsg SignIn.Msg


type alias Flags =
    ()



-- Init


performInit : Flags -> Url -> Nav.Key -> ( Model Nav.Key, Cmd Msg )
performInit flags url key =
    Effect.perform (init flags url key)


init : Flags -> Url -> key -> ( Model key, Effect Msg )
init _ url key =
    initialModel key |> changePageTo url


initialModel : key -> Model key
initialModel key =
    { page = NotFound
    , user = User.Guest
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

        NotFound ->
            NotFound.view
