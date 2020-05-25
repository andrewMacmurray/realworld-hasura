module Main exposing (main)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Navigation
import Element exposing (..)
import Page.Home as Home
import Page.NotFound as NotFound
import Page.Signup as Signup
import Route
import Url exposing (Url)



-- Program


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }



-- Model


type alias Model =
    { page : Page
    , navKey : Navigation.Key
    }


type Page
    = Home Home.Model
    | Signup Signup.Model
    | NotFound


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | HomeMsg Home.Msg
    | SignupMsg Signup.Msg


type alias Flags =
    ()



-- Init


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    initialModel key |> changePageTo url


initialModel : Navigation.Key -> Model
initialModel key =
    { page = Signup Signup.init
    , navKey = key
    }



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.page ) of
        ( UrlRequest urlRequest, _ ) ->
            handleUrl model urlRequest

        ( UrlChange url, _ ) ->
            changePageTo url model

        ( HomeMsg msg_, Home model_ ) ->
            Home.update msg_ model_
                |> updateWith Home HomeMsg model

        ( SignupMsg msg_, Signup model_ ) ->
            Signup.update msg_ model_
                |> updateWith Signup SignupMsg model

        ( _, _ ) ->
            ( model, Cmd.none )


handleUrl : Model -> UrlRequest -> ( Model, Cmd Msg )
handleUrl model request =
    case request of
        Browser.Internal url ->
            ( model, Navigation.pushUrl model.navKey (Url.toString url) )

        Browser.External url ->
            ( model, Navigation.load url )


updateWith modelF msgF model ( m, c ) =
    ( { model | page = modelF m }
    , Cmd.map msgF c
    )


changePageTo : Url -> Model -> ( Model, Cmd Msg )
changePageTo url model =
    case Route.fromUrl url of
        Just Route.Home ->
            Home.init |> updateWith Home HomeMsg model

        Just Route.Signup ->
            ( { model | page = Signup Signup.init }, Cmd.none )

        Nothing ->
            ( { model | page = NotFound }, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Document Msg
view model =
    { title = "Conduit"
    , body = [ layout [] (view_ model) ]
    }


view_ : Model -> Element Msg
view_ model =
    case model.page of
        Home model_ ->
            Home.view model_ |> Element.map HomeMsg

        Signup model_ ->
            Signup.view model_ |> Element.map SignupMsg

        NotFound ->
            NotFound.view
