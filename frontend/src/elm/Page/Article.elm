module Page.Article exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Api
import Api.Articles
import Article exposing (Article)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Avatar as Avatar
import Element.Background as Background
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



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> withBanner model
        |> Layout.toElement [ articleBody model.article ]


withBanner : Model -> Layout msg -> Layout msg
withBanner model layout =
    case model.article of
        Loaded article ->
            banner article layout

        _ ->
            layout


banner : Article -> Layout msg -> Layout msg
banner article =
    Layout.withBanner
        [ Background.color Palette.black ]
        (column [ spacing Scale.large ]
            [ headline article
            , author article
            ]
        )


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
            [ Text.link [ Text.white ] (Article.author article)
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
