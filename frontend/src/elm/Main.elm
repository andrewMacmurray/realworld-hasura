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



-- Program


main : Program Flags (Model Nav.Key) Msg
main =
    let
        update_ msg model =
            update msg model |> Tuple.mapSecond (Effect.perform model.navKey)

        init_ flags url key =
            init flags url key |> Tuple.mapSecond (Effect.perform key)
    in
    Browser.application
        { init = init_
        , update = update_
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }



-- Model


type alias Model key =
    { page : Page
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


init : Flags -> Url -> key -> ( Model key, Effect Msg )
init _ url key =
    initialModel key |> changePageTo url


initialModel : key -> Model key
initialModel key =
    { page = NotFound
    , navKey = key
    }



-- Update


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
            Home.view model_ |> Element.map HomeMsg

        SignUp model_ ->
            SignUp.view model_ |> Element.map SignUpMsg

        SignIn model_ ->
            SignIn.view model_ |> Element.map SignInMsg

        NotFound ->
            NotFound.view
