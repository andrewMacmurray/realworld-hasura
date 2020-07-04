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
import Element.Tab as Tab
import Element.Text as Text
import User exposing (User)



-- Model


type alias Model =
    { feed : Feed.Model
    , author : LoadStatus Author
    , activeTab : Tab
    }


type Msg
    = LoadAuthorResponseReceived (Api.Response (Maybe Author.Feed))
    | LikedArticlesClicked
    | AuthoredArticlesClicked
    | FeedMsg Feed.Msg
    | FollowMsg Follow.Msg


type Tab
    = AuthoredArticles
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
    , activeTab = AuthoredArticles
    }


fetchAuthorFeed : User.Id -> Effect Msg
fetchAuthorFeed id_ =
    Authors.loadFeed Authors.authoredArticles id_ LoadAuthorResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadAuthorResponseReceived (Ok (Just authorFeed)) ->
            ( { model | author = Loaded authorFeed.author, feed = Feed.loaded authorFeed.articles }
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

        LikedArticlesClicked ->
            handleLoadLikedArticles model

        AuthoredArticlesClicked ->
            handleLoadAuthoredArticles model


handleLoadLikedArticles : Model -> ( Model, Effect Msg )
handleLoadLikedArticles model =
    loadFeed Authors.likedArticles model
        |> embedFeed { model | activeTab = LikedArticles }


handleLoadAuthoredArticles : Model -> ( Model, Effect Msg )
handleLoadAuthoredArticles model =
    loadFeed Authors.authoredArticles model
        |> embedFeed { model | activeTab = AuthoredArticles }


loadFeed : Authors.ArticlesSelection -> Model -> ( Feed.Model, Effect Feed.Msg )
loadFeed selection model =
    case model.author of
        Loaded author ->
            Feed.load (selection (Author.id author))

        _ ->
            ( model.feed, Effect.none )


embedFeed : Model -> ( Feed.Model, Effect Feed.Msg ) -> ( Model, Effect Msg )
embedFeed =
    Feed.embedWith FeedMsg


handleFollowEffect : Follow.Msg -> Effect Msg
handleFollowEffect =
    Follow.effect >> Effect.map FollowMsg



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner user model
        |> Layout.toPage (pageContents user model)



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
    column [ width fill, spacing Scale.large ]
        [ tabs model.activeTab
        , feed user model
        ]


tabs : Tab -> Element Msg
tabs activeTab =
    case activeTab of
        AuthoredArticles ->
            Tab.tabs
                [ Tab.active "By Author"
                , Tab.link LikedArticlesClicked "Liked"
                ]

        LikedArticles ->
            Tab.tabs
                [ Tab.link AuthoredArticlesClicked "By Author"
                , Tab.active "Liked"
                ]


feed : User -> Model -> Element Msg
feed user model =
    case model.author of
        Loading ->
            Text.text [] "Loading..."

        Failed ->
            Text.error [ Text.description "error-message" ] "Something went wrong"

        NotFound ->
            Text.text [ Text.description "not-found-message" ] "Author not found"

        Loaded _ ->
            Feed.view
                { user = user
                , feed = model.feed
                , msg = FeedMsg
                }
