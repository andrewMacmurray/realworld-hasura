module Page.Home exposing
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
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Border as Border
import Element.Button as Button
import Element.Divider as Divider
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.String as String
import WebData exposing (WebData)



-- Model


type alias Model =
    { feed : WebData Article.Feed
    , selectedTag : Maybe Tag
    }


type Msg
    = GlobalFeedResponseReceived (Api.Response Article.Feed)
    | TagFeedResponseReceived (Api.Response Article.Feed)
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article
    | UpdateArticleResponseReceived (Api.Response Article)



-- Init


init : Maybe Tag -> ( Model, Effect Msg )
init tag =
    ( initialModel tag, fetchFeed tag )


fetchFeed : Maybe Tag -> Effect Msg
fetchFeed selectedTag =
    case selectedTag of
        Just tag ->
            Api.Articles.tagFeed tag TagFeedResponseReceived

        Nothing ->
            Api.Articles.globalFeed GlobalFeedResponseReceived


initialModel : Maybe Tag -> Model
initialModel tag =
    { feed = WebData.Loading
    , selectedTag = tag
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GlobalFeedResponseReceived response ->
            ( { model | feed = WebData.fromResult response }, Effect.none )

        TagFeedResponseReceived response ->
            ( { model | feed = WebData.fromResult response }, Effect.none )

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnLikeArticleClicked article ->
            ( model, unlikeArticle article )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | feed = WebData.map (Article.replace article) model.feed }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
            ( model, Effect.none )


likeArticle : Article -> Effect Msg
likeArticle article =
    Api.Articles.like article UpdateArticleResponseReceived


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article UpdateArticleResponseReceived



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toElement [ pageContents user model ]


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ el [ centerX ] (whiteHeadline "conduit")
        , el [ centerX ] (whiteSubtitle "A place to share your knowledge")
        ]


whiteSubtitle : String -> Element msg
whiteSubtitle =
    Text.subtitle [ Text.regular, Text.white ]


whiteHeadline : String -> Element msg
whiteHeadline =
    Text.headline [ Text.white ]


pageContents : User -> Model -> Element Msg
pageContents user model =
    case model.feed of
        WebData.Loading ->
            Text.text [] "Loading"

        WebData.Success feed_ ->
            row [ width fill, spacing Scale.large ]
                [ feedArticles user model.selectedTag feed_.articles
                , popularTags feed_.popularTags
                ]

        WebData.Failure ->
            Text.error [] "Something Went wrong"


popularTags : List Tag.Popular -> Element msg
popularTags tags_ =
    column
        [ Anchor.description "popular-tags"
        , alignTop
        , spacing Scale.large
        , width (fill |> maximum 300)
        ]
        [ Text.title [] "Popular Tags"
        , wrappedRow [ spacing Scale.small ] (List.map viewPopularTag tags_)
        ]


viewPopularTag : Tag.Popular -> Element msg
viewPopularTag t =
    Route.el (Route.tagFeed t.tag)
        (row
            [ spacing 4
            , Anchor.description ("popular-" ++ Tag.value t.tag)
            ]
            [ Text.link [] ("#" ++ Tag.value t.tag)
            , el
                [ Background.color Palette.deepGreen
                , Border.rounded 10000
                , alignTop
                , moveUp 5
                , width (px 18)
                , height (px 18)
                ]
                (el [ centerX, centerY ] (whiteLabel (String.fromInt t.count)))
            ]
        )


whiteLabel : String -> Element msg
whiteLabel =
    Text.label [ Text.white ]


feedArticles : User -> Maybe Tag -> List Article -> Element Msg
feedArticles user selectedTag articles =
    case selectedTag of
        Just tag ->
            column
                [ Anchor.description ("tag-feed-for-" ++ Tag.value tag)
                , width fill
                , spacing Scale.large
                ]
                [ row [ spacing Scale.large ]
                    [ Route.el Route.home (subtitleLink "Global Feed")
                    , greenSubtitle ("#" ++ String.capitalize (Tag.value tag))
                    ]
                , viewArticles user articles
                ]

        Nothing ->
            column
                [ Anchor.description "global-feed"
                , width fill
                , spacing Scale.large
                ]
                [ greenSubtitle "Global Feed"
                , viewArticles user articles
                ]


subtitleLink : String -> Element msg
subtitleLink =
    Text.subtitle [ Text.asLink ]


greenSubtitle : String -> Element msg
greenSubtitle =
    Text.subtitle [ Text.green ]


viewArticles : User -> List Article -> Element Msg
viewArticles user articles =
    column
        [ spacing Scale.large
        , width fill
        ]
        (List.map (viewArticle user) articles)


viewArticle : User -> Article -> Element Msg
viewArticle user article =
    column
        [ anchor article
        , spacing Scale.medium
        , width fill
        ]
        [ Divider.divider
        , row [ width fill ]
            [ column [ spacing Scale.medium, width fill ]
                [ row [ width fill ] [ profile article, likes user article ]
                , articleSummary article
                , row [ width fill ] [ readMore article, tags article ]
                ]
            ]
        ]


likes : User -> Article -> Element Msg
likes user article =
    let
        likeCount =
            Article.likes article |> String.fromInt
    in
    el [ alignRight ]
        (case user of
            Guest ->
                Button.decorative likeCount
                    |> Button.like
                    |> Button.toElement

            LoggedIn profile_ ->
                if Article.likedByMe profile_ article then
                    Button.button (UnLikeArticleClicked article) likeCount
                        |> Button.description ("unlike-" ++ Article.title article)
                        |> Button.like
                        |> Button.solid
                        |> Button.toElement

                else
                    Button.button (LikeArticleClicked article) likeCount
                        |> Button.description ("like-" ++ Article.title article)
                        |> Button.like
                        |> Button.toElement
        )


readMore : Article -> Element msg
readMore article =
    linkToArticle article (Text.label [] "READ MORE...")


articleSummary : Article -> Element msg
articleSummary article =
    linkToArticle article
        (column [ spacing Scale.small ]
            [ paragraph [] [ Text.subtitle [] (Article.title article) ]
            , Text.text [] (Article.about article)
            ]
        )


anchor : Article -> Attribute msg
anchor article =
    Anchor.description ("article-" ++ Article.title article)


profile : Article -> Element msg
profile article =
    row [ spacing Scale.small ]
        [ Avatar.large (Article.profileImage article)
        , column [ spacing Scale.small ]
            [ Text.link [ Text.green ] (Article.author article)
            , Text.date [] (Article.createdAt article)
            ]
        ]


tags : Article -> Element msg
tags article =
    el [ width fill, alignBottom ]
        (wrappedRow
            [ spacing Scale.small
            , alignRight
            , paddingEach { edges | left = Scale.medium }
            ]
            (List.map viewTag (Article.tags article))
        )


viewTag : Tag.Tag -> Element msg
viewTag t =
    Route.link (Route.tagFeed t) ("#" ++ Tag.value t)


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
