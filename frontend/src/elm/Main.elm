module Main exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , main
    , update
    , view
    )

import Api
import Api.Users
import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Context exposing (Context)
import Effect exposing (Effect)
import Element
import Element.Layout as Layout
import Page exposing (Page)
import Ports
import Url exposing (Url)
import User exposing (User)
import Utils.Update exposing (andThenWithEffect, updateWith)



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
    , context : Context
    , navKey : key
    }


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url
    | PageMsg Page.Msg
    | RefreshUserResponseReceived (Api.Response User)


type alias Flags =
    { user : Maybe Ports.User
    }



-- Init


performInit : Flags -> Url -> Nav.Key -> ( Model Nav.Key, Cmd Msg )
performInit flags url key =
    init flags url key
        |> Effect.perform Nav.pushUrl


init : Flags -> Url -> key -> ( Model key, Effect Msg )
init flags url key =
    Page.init
        |> Page.changeTo url (Context.init flags.user)
        |> updatePageWith (initialModel flags key)
        |> andThenWithEffect refreshUser


refreshUser : Model model -> Effect Msg
refreshUser model =
    Api.Users.refresh model.context.user RefreshUserResponseReceived


initialModel : Flags -> key -> Page -> Model key
initialModel flags key page =
    { page = page
    , context = Context.init flags.user
    , navKey = key
    }



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
            updatePage model (Page.changeTo url model.context model.page)

        PageMsg msg_ ->
            updatePage model (Page.update msg_ model.page)

        RefreshUserResponseReceived response ->
            ( model, Effect.updateUser response )


handleUrl : Model key -> UrlRequest -> ( Model key, Effect Msg )
handleUrl model request =
    case request of
        Browser.Internal url ->
            ( model, Effect.pushUrl url )

        Browser.External url ->
            ( model, Effect.loadUrl url )


updatePage : Model m -> ( Page, Effect Page.Msg ) -> ( Model m, Effect Msg )
updatePage model =
    updatePageWith (\page -> { model | page = page })


updatePageWith : (subModel -> model) -> ( subModel, Effect Page.Msg ) -> ( model, Effect Msg )
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
    , body = [ Layout.toHtml (view_ model) ]
    }


view_ : Model key -> Element.Element Msg
view_ { context, page } =
    Element.map PageMsg (Page.view context page)
