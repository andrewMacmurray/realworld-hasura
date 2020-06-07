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
import Element.Background as Background
import Element.Border as Border
import Element.Divider as Divider
import Element.Events exposing (onClick)
import Element.Feed as Feed
import Element.Layout as Layout
import Element.Palette as Palette
import Element.Scale as Scale
import Element.Text as Text
import Route
import Tag exposing (Tag)
import User exposing (User(..))
import Utils.String as String
import WebData exposing (WebData)



-- Model


type alias Model =
    { feed : Feed
    }


type Msg
    = GlobalFeedResponseReceived (Api.Response Article.Feed)
    | TagFeedResponseReceived Tag (Api.Response Article.Feed)
    | UserFeedResponseReceived (Api.Response Article.Feed)
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article
    | GlobalFeedClicked
    | UserFeedClicked User.Profile
    | UpdateArticleResponseReceived (Api.Response Article)


type Feed
    = Global (WebData Article.Feed)
    | UserFeed (WebData Article.Feed)
    | TagFeed Tag (WebData Article.Feed)



-- Init


init : User -> Maybe Tag -> ( Model, Effect Msg )
init user tag =
    ( initialModel user tag
    , fetchFeed user tag
    )


fetchFeed : User -> Maybe Tag -> Effect Msg
fetchFeed user tag =
    case ( user, tag ) of
        ( _, Just t ) ->
            Api.Articles.tagFeed t (TagFeedResponseReceived t)

        ( User.Guest, _ ) ->
            loadGlobalFeed

        ( User.LoggedIn profile_, _ ) ->
            loadUserFeed profile_


initialModel : User -> Maybe Tag -> Model
initialModel user tag =
    { feed = toInitialFeed user tag
    }


toInitialFeed : User -> Maybe Tag -> Feed
toInitialFeed user tag =
    case ( user, tag ) of
        ( _, Just t ) ->
            TagFeed t WebData.Loading

        ( User.LoggedIn _, _ ) ->
            UserFeed WebData.Loading

        ( User.Guest, _ ) ->
            Global WebData.Loading



-- Update


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GlobalFeedResponseReceived response ->
            ( { model | feed = Global (WebData.fromResult response) }, Effect.none )

        TagFeedResponseReceived tag response ->
            ( { model | feed = TagFeed tag (WebData.fromResult response) }, Effect.none )

        UserFeedResponseReceived response ->
            ( { model | feed = UserFeed (WebData.fromResult response) }, Effect.none )

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnLikeArticleClicked article ->
            ( model, unlikeArticle article )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | feed = updateArticle (Article.replaceInFeed article) model.feed }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
            ( model, Effect.none )

        GlobalFeedClicked ->
            ( { model | feed = Global WebData.Loading }, loadGlobalFeed )

        UserFeedClicked profile_ ->
            ( { model | feed = UserFeed WebData.Loading }, loadUserFeed profile_ )


loadGlobalFeed : Effect Msg
loadGlobalFeed =
    Api.Articles.globalFeed GlobalFeedResponseReceived


loadUserFeed : User.Profile -> Effect Msg
loadUserFeed profile_ =
    Api.Articles.userFeed profile_ UserFeedResponseReceived


likeArticle : Article -> Effect Msg
likeArticle article =
    Api.Articles.like article UpdateArticleResponseReceived


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article UpdateArticleResponseReceived



-- Feed


updateArticle : (Article.Feed -> Article.Feed) -> Feed -> Feed
updateArticle f feed =
    case feed of
        Global feed_ ->
            Global (WebData.map f feed_)

        UserFeed feed_ ->
            UserFeed (WebData.map f feed_)

        TagFeed tag feed_ ->
            TagFeed tag (WebData.map f feed_)



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
    pageWrapper user model (feedLinks user model.feed)


pageWrapper : User -> Model -> List (Element Msg) -> Element Msg
pageWrapper user model =
    case model.feed of
        Global feed_ ->
            feedWrapper user feed_ "global-feed"

        TagFeed tag_ feed_ ->
            feedWrapper user feed_ ("tag-feed-for-" ++ Tag.value tag_)

        UserFeed feed_ ->
            feedWrapper user feed_ "your-feed"



-- Links


feedLinks : User -> Feed -> List (Element Msg)
feedLinks user feed =
    case user of
        User.Guest ->
            guestLinks feed

        User.LoggedIn profile_ ->
            userLinks profile_ feed


userLinks : User.Profile -> Feed -> List (Element Msg)
userLinks profile_ feed =
    case feed of
        Global _ ->
            [ greenSubtitle "Global Feed"
            , userFeedLink profile_ (subtitleLink "Your Feed")
            ]

        UserFeed _ ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , el [] (greenSubtitle "Your Feed")
            ]

        TagFeed tag_ _ ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , userFeedLink profile_ (subtitleLink "Your Feed")
            , greenSubtitle ("#" ++ String.capitalize (Tag.value tag_))
            ]


guestLinks : Feed -> List (Element Msg)
guestLinks feed =
    case feed of
        Global _ ->
            [ greenSubtitle "Global Feed"
            ]

        TagFeed tag_ _ ->
            [ globalFeedLink (subtitleLink "Global Feed")
            , greenSubtitle ("#" ++ String.capitalize (Tag.value tag_))
            ]

        UserFeed _ ->
            []


globalFeedLink : Element Msg -> Element Msg
globalFeedLink =
    el [ onClick GlobalFeedClicked ]


userFeedLink : User.Profile -> Element Msg -> Element Msg
userFeedLink profile_ =
    el [ onClick (UserFeedClicked profile_) ]



-- Page


feedWrapper : User -> WebData Article.Feed -> String -> List (Element Msg) -> Element Msg
feedWrapper user feed description links =
    row [ width fill, spacing Scale.large ]
        [ column
            [ Anchor.description description
            , width fill
            , spacing Scale.large
            ]
            [ row [ spacing Scale.large ] links
            , Divider.divider
            , viewFeed user feed
            ]
        , column
            [ Anchor.description "popular-tags"
            , alignTop
            , spacing Scale.large
            , width (fill |> maximum 300)
            ]
            [ Text.title [] "Popular Tags"
            , viewPopularTags feed
            ]
        ]


viewFeed : User -> WebData Article.Feed -> Element Msg
viewFeed user feed =
    case feed of
        WebData.Loading ->
            Text.text [] "Loading Feed"

        WebData.Success data ->
            Feed.articles
                { onLike = LikeArticleClicked
                , onUnlike = UnLikeArticleClicked
                , user = user
                , articles = data.articles
                }

        WebData.Failure ->
            Text.error [] "Something went wrong"


viewPopularTags : WebData Article.Feed -> Element msg
viewPopularTags feed =
    case feed of
        WebData.Loading ->
            none

        WebData.Success data ->
            wrappedRow [ spacing Scale.small ] (List.map viewPopularTag data.popularTags)

        WebData.Failure ->
            none


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


subtitleLink : String -> Element msg
subtitleLink =
    Text.subtitle [ Text.asLink ]


greenSubtitle : String -> Element msg
greenSubtitle =
    Text.subtitle [ Text.green ]
