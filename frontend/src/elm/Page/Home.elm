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
import Element.Divider as Divider
import Element.FancyText as FancyText
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



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toElement [ pageContents model ]


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ el [ centerX ] (whiteHeadline "conduit")
        , el [ centerX ] (whiteSubtitle "A place to share your knowledge")
        ]


whiteSubtitle =
    FancyText.subtitle
        |> FancyText.regular
        |> FancyText.white
        |> FancyText.el


whiteHeadline =
    FancyText.headline
        |> FancyText.white
        |> FancyText.el


pageContents : Model -> Element msg
pageContents model =
    case model.feed of
        WebData.Loading ->
            Text.text [] "Loading"

        WebData.Success feed_ ->
            row [ width fill, spacing Scale.large ]
                [ feedArticles model.selectedTag feed_.articles
                , popularTags feed_.popularTags
                ]

        WebData.Failure ->
            FancyText.error "Something Went wrong"


popularTags : List Tag.Popular -> Element msg
popularTags tags_ =
    column
        [ Anchor.description "popular-tags"
        , alignTop
        , spacing Scale.large
        , width (fill |> maximum 300)
        ]
        [ FancyText.el FancyText.title "Popular Tags"
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


whiteLabel =
    FancyText.label
        |> FancyText.white
        |> FancyText.el


feedArticles : Maybe Tag -> List Article -> Element msg
feedArticles selectedTag articles =
    case selectedTag of
        Just tag ->
            column
                [ Anchor.description ("tag-feed-for-" ++ Tag.value tag)
                , width fill
                , spacing Scale.large
                ]
                [ row [ spacing Scale.large ]
                    [ subtitleLink "Global Feed"
                    , greenSubtitle ("#" ++ String.capitalize (Tag.value tag))
                    ]
                , viewArticles articles
                ]

        Nothing ->
            column
                [ Anchor.description "global-feed"
                , width fill
                , spacing Scale.large
                ]
                [ greenSubtitle "Global Feed"
                , viewArticles articles
                ]


subtitleLink =
    FancyText.subtitle |> FancyText.asLink |> FancyText.el


greenSubtitle =
    FancyText.subtitle |> FancyText.green |> FancyText.el


viewArticles : List Article -> Element msg
viewArticles articles =
    column
        [ spacing Scale.large
        , width fill
        ]
        (List.map viewArticle articles)


viewArticle : Article -> Element msg
viewArticle article =
    column
        [ anchor article
        , spacing Scale.medium
        , width fill
        ]
        [ Divider.divider
        , row [ width fill ]
            [ column [ spacing Scale.medium, width fill ]
                [ profile article
                , articleSummary article
                , row [ width fill ] [ readMore article, tags article ]
                ]
            ]
        ]


readMore : Article -> Element msg
readMore article =
    linkToArticle article (FancyText.el FancyText.label "READ MORE...")


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
            [ Text.greenLink [] (Article.author article)
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
