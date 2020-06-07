module Page.Author exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Authors
import Article exposing (Author)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button as Button
import Element.Layout as Layout exposing (Layout)
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import User exposing (User)



-- Model


type alias Model =
    { author : LoadStatus Author }


type Msg
    = AuthorResponseReceived (Api.Response (Maybe Author))


type LoadStatus a
    = Loading
    | Failed
    | NotFound
    | Loaded a



-- Init


init : User.Id -> ( Model, Effect Msg )
init id_ =
    ( initialModel, getAuthor id_ )


initialModel : Model
initialModel =
    { author = Loading }


getAuthor : User.Id -> Effect Msg
getAuthor id_ =
    Api.Authors.get id_ AuthorResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        AuthorResponseReceived (Ok (Just author_)) ->
            ( { model | author = Loaded author_ }, Effect.none )

        AuthorResponseReceived (Ok Nothing) ->
            ( { model | author = NotFound }, Effect.none )

        AuthorResponseReceived (Err _) ->
            ( { model | author = Failed }, Effect.none )



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner model
        |> Layout.toElement []


withBanner : Model -> Layout msg -> Layout msg
withBanner model =
    Layout.withBanner [ Background.color Palette.black ] (bannerContent model.author)


bannerContent : LoadStatus Author -> Element msg
bannerContent a =
    case a of
        Loaded a_ ->
            column [ spacing Scale.small, centerY ]
                [ row [ spacing Scale.small ]
                    [ Avatar.large a_.profileImage
                    , Text.headline [ Text.white ] a_.username
                    ]
                , Button.decorative "Follow Author"
                    |> Button.follow
                    |> Button.toElement
                ]

        _ ->
            none
