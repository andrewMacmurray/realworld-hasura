module Page.Article exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Api.Users
import Article exposing (Article)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Button as Button
import Element.Layout as Layout exposing (Layout)
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Route
import Tag exposing (Tag)
import User exposing (User(..))



-- Model


type alias Model =
    { article : LoadStatus Article
    }


type Msg
    = ArticleReceived (Api.Response (Maybe Article))
    | FollowAuthorClicked Article
    | FollowResponseReceived (Api.Response Int)
    | UnfollowAuthorClicked Article
    | UnfollowResponseReceived (Api.Response Int)


type LoadStatus a
    = Loading
    | Loaded a
    | NotFound
    | FailedToLoad



-- Init


init : Article.Id -> ( Model, Effect Msg )
init id =
    ( initialModel, loadArticle id )


loadArticle : Article.Id -> Effect Msg
loadArticle id =
    Api.Articles.loadArticle id ArticleReceived


initialModel : Model
initialModel =
    { article = Loading
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ArticleReceived (Ok (Just article)) ->
            ( { model | article = Loaded article }, Effect.none )

        ArticleReceived (Ok Nothing) ->
            ( { model | article = NotFound }, Effect.none )

        ArticleReceived (Err _) ->
            ( { model | article = FailedToLoad }, Effect.none )

        FollowAuthorClicked article ->
            ( model, followAuthor article )

        FollowResponseReceived (Ok following_id) ->
            ( model, Effect.addToUserFollows following_id )

        FollowResponseReceived (Err _) ->
            ( model, Effect.none )

        UnfollowAuthorClicked article ->
            ( model, unfollowAuthor article )

        UnfollowResponseReceived (Ok following_id) ->
            ( model, Effect.removeFromUserFollows following_id )

        UnfollowResponseReceived (Err _) ->
            ( model, Effect.none )


followAuthor : Article -> Effect Msg
followAuthor article =
    Api.Users.follow (Article.author article) FollowResponseReceived


unfollowAuthor : Article -> Effect Msg
unfollowAuthor article =
    Api.Users.unfollow (Article.author article) UnfollowResponseReceived



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner user model
        |> Layout.toElement [ articleBody model.article ]


withBanner : User -> Model -> Layout Msg -> Layout Msg
withBanner user model layout =
    case model.article of
        Loaded article ->
            banner user article layout

        _ ->
            layout


banner : User -> Article -> Layout Msg -> Layout Msg
banner user article =
    Layout.withBanner
        [ Background.color Palette.black ]
        (column [ spacing Scale.large ]
            [ headline article
            , row [ spacing Scale.medium ]
                [ author article
                , followButton user article
                ]
            ]
        )


followButton : User -> Article -> Element Msg
followButton user article =
    case user of
        User.Guest ->
            none

        User.LoggedIn profile ->
            if Article.isAuthoredBy profile article then
                none

            else if User.follows (Article.authorId article) profile then
                Button.button (UnfollowAuthorClicked article) "Unfollow"
                    |> Button.description ("unfollow-" ++ Article.authorUsername article)
                    |> Button.follow
                    |> Button.toElement

            else
                Button.button (FollowAuthorClicked article) "Follow"
                    |> Button.description ("follow-" ++ Article.authorUsername article)
                    |> Button.follow
                    |> Button.toElement


tags : Article -> Element msg
tags article =
    row [ spacing Scale.small ] (List.map viewTag <| Article.tags article)


viewTag : Tag -> Element msg
viewTag tag =
    Route.el (Route.tagFeed tag) (Text.link [] ("#" ++ Tag.value tag))


headline : Article -> Element msg
headline article =
    paragraph []
        [ Text.headline
            [ Text.white
            , Text.description "article-title"
            ]
            (Article.title article)
        ]


author : Article -> Element msg
author article =
    row [ spacing Scale.small ]
        [ Avatar.medium (Article.profileImage article)
        , column [ spacing Scale.extraSmall ]
            [ Text.link [ Text.white ] (Article.authorUsername article)
            , Text.date [] (Article.createdAt article)
            ]
        ]


articleBody : LoadStatus Article -> Element msg
articleBody article_ =
    case article_ of
        Loading ->
            Text.text [] "Loading..."

        Loaded a ->
            showArticleBody a

        NotFound ->
            Text.text [ Text.description "not-found-message" ] "Article Not Found"

        FailedToLoad ->
            Text.text [ Text.description "error-message" ] "There was an error loading the article"


showArticleBody : Article -> Element msg
showArticleBody a =
    column [ spacing Scale.large, width fill ]
        [ row [ width fill ]
            [ Text.subtitle [] (Article.about a)
            , el [ alignRight ] (tags a)
            ]
        , Text.text [] (Article.content a)
        ]
