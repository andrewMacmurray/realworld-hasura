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
import Article.Author.Follow as Follow
import Article.Component.Feed as Feed
import Article.Feed as Feed
import Article.Page as Page
import Context exposing (Context)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button as Button
import Element.Layout as Layout exposing (Layout)
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Tab as Tab
import Element.Text as Text
import Route
import User exposing (User)
import User.Element as Element



-- Model


type alias Model =
    { feed : Feed.Model
    , author : Api.Data Author
    , activeTab : Tab
    }


type Msg
    = LoadAuthorResponseReceived (Api.Response (Maybe Feed.ForAuthor))
    | LikedArticlesClicked
    | AuthoredArticlesClicked
    | FeedMsg Feed.Msg
    | FollowMsg Follow.Msg


type Tab
    = AuthoredArticles
    | LikedArticles



-- Init


init : Author.Id -> ( Model, Effect Msg )
init id =
    ( initialModel id, fetchAuthorFeed id )


initialModel : Author.Id -> Model
initialModel id =
    { feed = Feed.loading (Authors.authoredArticles id)
    , author = Api.Loading
    , activeTab = AuthoredArticles
    }


fetchAuthorFeed : Author.Id -> Effect Msg
fetchAuthorFeed id_ =
    Authors.loadFeed Authors.authoredArticles id_ Page.first LoadAuthorResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        LoadAuthorResponseReceived res ->
            ( handleLoadResponse model res, Effect.none )

        FeedMsg msg_ ->
            Feed.update FeedMsg msg_ model

        FollowMsg msg_ ->
            ( model, handleFollowEffect msg_ )

        LikedArticlesClicked ->
            handleLoadLikedArticles model

        AuthoredArticlesClicked ->
            handleLoadAuthoredArticles model


handleLoadResponse : Model -> Api.Response (Maybe Feed.ForAuthor) -> Model
handleLoadResponse model response =
    { model
        | author = Api.mapData .author (Api.fromNullableResponse response)
        , feed = Feed.fromNullableResponse response model.feed
    }


handleLoadLikedArticles : Model -> ( Model, Effect Msg )
handleLoadLikedArticles model =
    loadFeed Authors.likedArticles model
        |> embedFeed { model | activeTab = LikedArticles }


handleLoadAuthoredArticles : Model -> ( Model, Effect Msg )
handleLoadAuthoredArticles model =
    loadFeed Authors.authoredArticles model
        |> embedFeed { model | activeTab = AuthoredArticles }


loadFeed : Authors.FeedSelection -> Model -> ( Feed.Model, Effect Feed.Msg )
loadFeed selection model =
    case model.author of
        Api.Success author ->
            Feed.load (selection (Author.id author))

        _ ->
            ( model.feed, Effect.none )


embedFeed : Model -> ( Feed.Model, Effect Feed.Msg ) -> ( Model, Effect Msg )
embedFeed =
    Feed.embed FeedMsg


handleFollowEffect : Follow.Msg -> Effect Msg
handleFollowEffect =
    Follow.effect >> Effect.map FollowMsg



-- View


view : Context -> Model -> Element Msg
view context model =
    Layout.layout
        |> withBanner context.user model
        |> Layout.toPage context (pageContents context.user model)



-- Banner


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model =
    Layout.withBanner [ Background.color Palette.black ] (bannerContent user model.author)


bannerContent : User -> Api.Data Author -> Element Msg
bannerContent user author =
    case author of
        Api.Success author_ ->
            column [ spacing Scale.small, centerY ]
                [ row [ spacing Scale.small ]
                    [ Avatar.large (Author.profileImage author_)
                    , authorName author_
                    ]
                , followButton user author_
                , newPostButton user author_
                ]

        _ ->
            none


authorName : Author -> Element msg
authorName author_ =
    Text.mobileHeadline [ Text.white ] (Author.username author_)


newPostButton : User -> Author -> Element msg
newPostButton =
    Element.showIfMe
        (row [ spacing Scale.extraSmall ]
            [ Route.button Route.NewArticle "New Post"
                |> Button.follow
                |> Button.toElement
            , Route.button Route.Settings "Edit Settings"
                |> Button.edit
                |> Button.toElement
            ]
        )


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
                [ Tab.active "by author"
                , Tab.link LikedArticlesClicked "liked"
                ]

        LikedArticles ->
            Tab.tabs
                [ Tab.link AuthoredArticlesClicked "by author"
                , Tab.active "liked"
                ]


feed : User -> Model -> Element Msg
feed user model =
    case model.author of
        Api.Loading ->
            Feed.loadingMessage

        Api.Failure ->
            Text.error [ Text.description "error-message" ] "Something went wrong"

        Api.NotFound ->
            Text.text [ Text.description "not-found-message" ] "Author not found"

        Api.Success _ ->
            Feed.view
                { user = user
                , feed = model.feed
                , msg = FeedMsg
                }
