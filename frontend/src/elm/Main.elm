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
import Element exposing (layout)
import Page exposing (Page)
import Ports
import Url exposing (Url)
import User exposing (User)
import Utils.Update exposing (updateWith)



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


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | PageMsg Page.Msg


type alias Flags =
    { user : Maybe Ports.User
    }



-- Init


performInit : Flags -> Url -> Nav.Key -> ( Model Nav.Key, Cmd Msg )
performInit flags url key =
    Effect.perform Nav.pushUrl (init flags url key)


init : Flags -> Url -> key -> ( Model key, Effect Msg )
init flags url key =
    updatePageWith (initialModel flags key) (Page.init (handleUser flags.user) url)


initialModel : Flags -> key -> Page -> Model key
initialModel flags key page =
    { page = page
    , user = handleUser flags.user
    , navKey = key
    }


handleUser : Maybe Ports.User -> User
handleUser =
    Maybe.map Ports.toLoggedIn >> Maybe.withDefault User.Guest



-- Update


performUpdate : Msg -> Model Nav.Key -> ( Model Nav.Key, Cmd Msg )
performUpdate msg model =
    Effect.perform Nav.pushUrl (update msg model)


update : Msg -> Model key -> ( Model key, Effect Msg )
update msg model =
    case msg of
        UrlRequest urlRequest ->
            handleUrl model urlRequest

        UrlChange url ->
            updatePage model (Page.init model.user url)

        PageMsg msg_ ->
            updatePage model (Page.update msg_ model.page)


handleUrl : Model key -> UrlRequest -> ( Model key, Effect Msg )
handleUrl model request =
    case request of
        Browser.Internal url ->
            ( model, Effect.pushUrl url )

        Browser.External url ->
            ( model, Effect.loadUrl url )


updatePage model =
    updatePageWith (\page -> { model | page = page })


updatePageWith f =
    updateWith f PageMsg



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


view_ : Model key -> Element.Element Msg
view_ { user, page } =
    Element.map PageMsg (Page.view user page)
