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
import Element.Font as Font
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Route
import Tag
import User exposing (User(..))
import WebData exposing (WebData)



-- Model


type alias Model =
    { globalFeed : WebData Article.Feed
    }


type Msg
    = GlobalFeedResponseReceived (Api.Response Article.Feed)



-- Init


init : ( Model, Effect Msg )
init =
    ( initialModel
    , Api.Articles.globalFeed GlobalFeedResponseReceived
    )


initialModel : Model
initialModel =
    { globalFeed = WebData.Loading
    }



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GlobalFeedResponseReceived response ->
            ( { model | globalFeed = WebData.fromResult response }, Effect.none )



-- View


view : User -> Model -> Element Msg
view user model =
    Layout.user user
        |> Layout.withBanner [ Background.color Palette.green ] banner
        |> Layout.toElement [ pageContents model ]


banner : Element msg
banner =
    column [ spacing Scale.medium, centerX ]
        [ Text.headline [ Font.color Palette.white, centerX ] "conduit"
        , Text.subtitle [ Font.color Palette.white, Font.regular, centerX ] "A place to share your knowledge"
        ]


pageContents : Model -> Element msg
pageContents model =
    case model.globalFeed of
        WebData.Loading ->
            Text.text [] "Loading"

        WebData.Success feed_ ->
            row [ width fill, spacing Scale.large ]
                [ allArticles feed_.articles
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
    row
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
            (Text.label
                [ centerX
                , centerY
                , Font.color Palette.white
                ]
                (String.fromInt t.count)
            )
        ]


allArticles : List Article -> Element msg
allArticles articles =
    column
        [ Anchor.description "global-feed"
        , width fill
        , spacing Scale.large
        ]
        [ Text.greenSubtitle [] "Global Feed"
        , viewArticles articles
        ]


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
                , readMore article
                ]
            , tags article
            ]
        ]


readMore : Article -> Element msg
readMore article =
    linkToArticle article (Text.label [] "Read more...")


articleSummary : Article -> Element msg
articleSummary article =
    linkToArticle article
        (column [ spacing Scale.small ]
            [ Text.subtitle [] (Article.title article)
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
    Text.link [] ("#" ++ Tag.value t)


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
