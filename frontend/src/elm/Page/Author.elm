module Page.Author exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Authors as Authors
import Article.Author as Author exposing (Author)
import Article.Author.Feed as Author
import Article.Author.Follow as Follow
import Article.Feed as Feed
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Layout as Layout exposing (Layout)
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import User exposing (User)



-- Model


type alias Model =
    { feed : Feed.Model
    , author : LoadStatus Author
    , tab : Tab
    }


type Msg
    = LoadAuthorResponseReceived (Api.Response (Maybe Author.Feed))
    | FeedMsg Feed.Msg
    | FollowMsg Follow.Msg


type Tab
    = MyArticles
    | LikedArticles


type LoadStatus a
    = Loading
    | Failed
    | NotFound
    | Loaded a



-- Init


init : User.Id -> ( Model, Effect Msg )
init id_ =
    ( initialModel, fetchAuthorFeed id_ )


initialModel : Model
initialModel =
    { feed = Feed.loading
    , author = Loading
    , tab = MyArticles
    }


fetchAuthorFeed : User.Id -> Effect Msg
fetchAuthorFeed id_ =
    Authors.loadFeed Authors.authoredArticles id_ LoadAuthorResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadAuthorResponseReceived (Ok (Just f)) ->
            ( { model | author = Loaded f.author, feed = Feed.loaded f.articles }
            , Effect.none
            )

        LoadAuthorResponseReceived (Ok Nothing) ->
            ( { model | author = NotFound }, Effect.none )

        LoadAuthorResponseReceived (Err _) ->
            ( { model | author = Failed }, Effect.none )

        FeedMsg msg_ ->
            Feed.updateWith FeedMsg msg_ model

        FollowMsg msg_ ->
            ( model, handleFollowEffect msg_ )


handleFollowEffect : Follow.Msg -> Effect Msg
handleFollowEffect =
    Follow.effect >> Effect.map FollowMsg



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner user model
        |> Layout.toElement [ pageContents user model ]



-- Banner


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model =
    Layout.withBanner [ Background.color Palette.black ] (bannerContent user model.author)


bannerContent : User -> LoadStatus Author -> Element Msg
bannerContent user author =
    case author of
        Loaded author_ ->
            column [ spacing Scale.small, centerY ]
                [ row [ spacing Scale.small ]
                    [ Avatar.large (Author.profileImage author_)
                    , Text.headline [ Text.white ] (Author.username author_)
                    ]
                , followButton user author_
                ]

        _ ->
            none


followButton : User -> Author -> Element Msg
followButton user author =
    Follow.button
        { user = user
        , author = author
        , msg = FollowMsg
        }



-- Page


pageContents : User -> Model -> Element Msg
pageContents user model =
    case model.author of
        Loading ->
            Text.text [] "Loading Author"

        Failed ->
            Text.error [] "Error Loading Author"

        NotFound ->
            Text.error [] "No Author found"

        Loaded _ ->
            Feed.view
                { user = user
                , feed = model.feed
                , msg = FeedMsg
                }
