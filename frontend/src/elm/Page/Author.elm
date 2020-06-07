module Page.Author exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Api.Authors
import Api.Users
import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Article.Author.Feed as Feed exposing (Feed)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button.Follow as Follow
import Element.Feed as Feed
import Element.Layout as Layout exposing (Layout)
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import User exposing (User)



-- Model


type alias Model =
    { feed : LoadStatus Feed
    }


type Msg
    = FeedResponseReceived (Api.Response (Maybe Feed))
    | LikeArticleClicked Article
    | UnlikeArticleClicked Article
    | FollowAuthorClicked Author
    | UnfollowAuthorClicked Author
    | UpdateArticleResponseReceived (Api.Response Article)
    | FollowResponseReceived (Api.Response User.Id)
    | UnfollowResponseReceived (Api.Response User.Id)


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
    { feed = Loading
    }


fetchAuthorFeed : User.Id -> Effect Msg
fetchAuthorFeed id_ =
    Api.Authors.feed id_ FeedResponseReceived



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        FeedResponseReceived (Ok (Just author_)) ->
            ( { model | feed = Loaded author_ }, Effect.none )

        FeedResponseReceived (Ok Nothing) ->
            ( { model | feed = NotFound }, Effect.none )

        FeedResponseReceived (Err _) ->
            ( { model | feed = Failed }, Effect.none )

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnlikeArticleClicked article ->
            ( model, unlikeArticle article )

        FollowAuthorClicked author_ ->
            ( model, followAuthor author_ )

        UnfollowAuthorClicked author_ ->
            ( model, unfollowAuthor author_ )

        FollowResponseReceived (Ok id) ->
            ( model, Effect.addToUserFollows id )

        FollowResponseReceived (Err _) ->
            ( model, Effect.none )

        UnfollowResponseReceived (Ok id) ->
            ( model, Effect.removeFromUserFollows id )

        UnfollowResponseReceived (Err _) ->
            ( model, Effect.none )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | feed = updateArticle article model.feed }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
            ( model, Effect.none )


updateArticle : Article -> LoadStatus Feed -> LoadStatus Feed
updateArticle article author =
    case author of
        Loaded a ->
            Loaded (Feed.replaceArticle article a)

        _ ->
            author


likeArticle : Article -> Effect Msg
likeArticle article =
    Api.Articles.like article UpdateArticleResponseReceived


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article UpdateArticleResponseReceived


followAuthor : Author -> Effect Msg
followAuthor author_ =
    Api.Users.follow author_ FollowResponseReceived


unfollowAuthor : Author -> Effect Msg
unfollowAuthor author_ =
    Api.Users.unfollow author_ UnfollowResponseReceived



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner user model
        |> Layout.toElement [ pageContents user model ]



-- Banner


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model =
    Layout.withBanner [ Background.color Palette.black ] (bannerContent user model.feed)


bannerContent : User -> LoadStatus Feed -> Element Msg
bannerContent user feed =
    case feed of
        Loaded feed_ ->
            column [ spacing Scale.small, centerY ]
                [ row [ spacing Scale.small ]
                    [ Avatar.large (Author.profileImage feed_.author)
                    , Text.headline [ Text.white ] (Author.username feed_.author)
                    ]
                , followButton user feed_.author
                ]

        _ ->
            none


followButton : User -> Author -> Element Msg
followButton user author =
    Follow.button
        { user = user
        , author = author
        , onFollow = FollowAuthorClicked
        , onUnfollow = UnfollowAuthorClicked
        }



-- Page


pageContents : User -> Model -> Element Msg
pageContents user model =
    case model.feed of
        Loading ->
            Text.text [] "Loading Author"

        Failed ->
            Text.error [] "Error Loading Author"

        NotFound ->
            Text.error [] "No Author found"

        Loaded a ->
            Feed.articles
                { onUnlike = UnlikeArticleClicked
                , onLike = LikeArticleClicked
                , user = user
                , articles = a.authoredArticles
                }
