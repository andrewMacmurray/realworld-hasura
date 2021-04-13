module Article.Component.Feed exposing
    ( Model
    , Msg
    , embed
    , fromNullableResponse
    , fromResponse
    , load
    , loading
    , loadingMessage
    , update
    , view
    )

import Animation exposing (Animation)
import Animation.Named as Animation
import Api
import Api.Articles
import Article exposing (Article)
import Article.Feed exposing (Feed)
import Article.Page as Page
import Browser.Dom exposing (Viewport)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Button as Button exposing (Button)
import Element.Divider as Divider
import Element.Keyed as Keyed
import Element.Loader.Conduit as Loader
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Route
import Tag exposing (Tag)
import User exposing (User)
import Utils.Element as Element
import Utils.Update as Update



-- Page Model


type alias PageModel model =
    { model | feed : Model }


type alias PageMsg msg =
    Msg -> msg



-- Model


type alias Model =
    { feed : Api.Data Feed
    , page : Page.Number
    , request : Request
    , selection : FeedSelection
    }


type alias FeedSelection =
    Page.Number -> SelectionSet Feed RootQuery


type Msg
    = LoadFeedResponseReceived (Api.Response Feed)
    | LoadMoreResponseReceived Viewport (Api.Response Feed)
    | LoadMoreClicked
    | LikesActionResponseReceived Article.Id (Api.Response Article)
    | PageScrolled
    | ViewportReceived Viewport
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article


type Request
    = Idle
    | LoadingMoreArticles
    | LoadMoreArticlesFailed
    | LikeInProgress Article.Id
    | UnlikeInProgress Article.Id
    | LikesActionFailed Article.Id



-- Init


fromResponse : Api.Response { res | feed : Feed } -> Model -> Model
fromResponse response model =
    Api.fromResponse response |> updateFeed model


fromNullableResponse : Result error (Maybe { res | feed : Feed }) -> Model -> Model
fromNullableResponse response model =
    Api.fromNullableResponse response |> updateFeed model


load : FeedSelection -> ( Model, Effect Msg )
load selection =
    ( loading selection
    , Api.Articles.loadFeed (selection Page.first) LoadFeedResponseReceived
    )


loading : FeedSelection -> Model
loading selection =
    { feed = Api.Loading
    , page = Page.first
    , request = Idle
    , selection = selection
    }


updateFeed : Model -> Api.Data { res | feed : Feed } -> Model
updateFeed model response =
    { model | feed = Api.mapData .feed response }



-- Update


embed : PageMsg msg -> PageModel model -> ( Model, Effect Msg ) -> ( PageModel model, Effect msg )
embed pageMsg pageModel =
    Update.updateWith (\feed -> { pageModel | feed = feed }) pageMsg


update : PageMsg msg -> Msg -> PageModel model -> ( PageModel model, Effect msg )
update pageMsg msg pageModel =
    update_ msg pageModel.feed |> embed pageMsg pageModel


update_ : Msg -> Model -> ( Model, Effect Msg )
update_ msg model =
    case msg of
        LoadFeedResponseReceived response ->
            ( { model | feed = Api.fromResponse response }, Effect.none )

        LoadMoreClicked ->
            ( { model | request = LoadingMoreArticles }, Effect.getViewport ViewportReceived )

        ViewportReceived viewport ->
            ( model, loadMore model viewport )

        LoadMoreResponseReceived viewport (Ok feed) ->
            ( { model
                | request = Idle
                , feed = appendToFeed feed model.feed
                , page = Page.next model.page
              }
            , Effect.setOffsetY PageScrolled viewport
            )

        LoadMoreResponseReceived _ (Err _) ->
            ( { model | request = LoadMoreArticlesFailed }, Effect.none )

        LikeArticleClicked article ->
            ( { model | request = LikeInProgress (Article.id article) }, likeArticle article )

        UnLikeArticleClicked article ->
            ( { model | request = UnlikeInProgress (Article.id article) }, unlikeArticle article )

        LikesActionResponseReceived _ (Ok article) ->
            ( { model
                | feed = Api.mapData (updateArticle article) model.feed
                , request = Idle
              }
            , Effect.none
            )

        LikesActionResponseReceived id (Err _) ->
            ( { model | request = LikesActionFailed id }, Effect.none )

        PageScrolled ->
            ( model, Effect.none )


appendToFeed : Feed -> Api.Data Feed -> Api.Data Feed
appendToFeed feed =
    Api.mapData (appendArticles feed.articles)


appendArticles : List Article -> Feed -> Feed
appendArticles articles feed =
    { feed | articles = feed.articles ++ articles }


updateArticle : Article -> Feed -> Feed
updateArticle article feed =
    { feed | articles = Article.replace article feed.articles }


likeArticle : Article -> Effect Msg
likeArticle article =
    Api.Articles.like article (LikesActionResponseReceived (Article.id article))


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article (LikesActionResponseReceived (Article.id article))


loadMore : Model -> Viewport -> Effect Msg
loadMore model viewport =
    Api.Articles.loadFeed (model.selection (Page.next model.page)) (LoadMoreResponseReceived viewport)



-- View


type alias Options msg =
    { msg : Msg -> msg
    , user : User
    , feed : Model
    }


view : Options msg -> Element msg
view options =
    case options.feed.feed of
        Api.Loading ->
            loadingMessage

        Api.Success feed_ ->
            Animation.embed fadeIn (viewFeed options feed_)

        Api.Failure ->
            Text.error [] "Error loading feed."

        Api.NotFound ->
            none


fadeIn : Animation
fadeIn =
    Animation.fadeIn 200 [ Animation.linear ]


loadingMessage : Element msg
loadingMessage =
    el
        [ moveLeft Scale.medium
        , moveUp Scale.small
        ]
        Loader.default


viewFeed : Options msg -> Feed -> Element msg
viewFeed options feed =
    column
        [ width fill
        , spacing Scale.extraLarge
        ]
        [ Keyed.column [ spacing Scale.large, width fill ] (List.map (viewArticle options) feed.articles)
        , loadMoreButton options feed
        ]


loadMoreButton : Options msg -> Feed -> Element msg
loadMoreButton options feed =
    case options.feed.request of
        LoadMoreArticlesFailed ->
            column [ centerX, spacing Scale.medium ]
                [ el [ centerX ] (loadMoreButton_ options feed)
                , Text.error [] "Error loading more, try again?"
                ]

        _ ->
            el [ centerX ] (loadMoreButton_ options feed)


loadMoreButton_ : Options msg -> Feed -> Element msg
loadMoreButton_ options feed =
    Element.map options.msg
        (Page.loadMoreButton
            { totalArticles = feed.count
            , loading = isLoadingMore options.feed.request
            , page = options.feed.page
            , onClick = LoadMoreClicked
            }
        )


isLoadingMore : Request -> Bool
isLoadingMore request =
    case request of
        LoadingMoreArticles ->
            True

        _ ->
            False


viewArticle : Options msg -> Article -> ( String, Element msg )
viewArticle options article =
    ( String.fromInt (Article.id article)
    , column
        [ anchor article
        , spacing Scale.medium
        , width fill
        ]
        [ row [ width fill ]
            [ column [ spacing Scale.medium, width fill ]
                [ row [ width fill ] [ profile article, likes options article ]
                , articleSummary article
                , row [ width fill ]
                    [ readMore article
                    , Element.desktopOnly el [ alignRight ] (tags article)
                    ]
                ]
            ]
        , Divider.divider
        ]
    )



-- Likes Button


type LikesButton msg
    = GuestLikesButton { count : String }
    | UnlikeButton { count : String, msg : Maybe msg, description : String }
    | LikeButton { count : String, msg : Maybe msg, description : String }
    | LikeInProgressButton { count : String }
    | UnlikeInProgressButton { count : String }


likes : Options msg -> Article -> Element msg
likes options article =
    el [ alignRight, alignTop ]
        (toLikesButton options article
            |> viewLikesButton
            |> Button.toElement
        )


requestIsInProgress : Request -> Bool
requestIsInProgress request =
    case request of
        Idle ->
            False

        LoadingMoreArticles ->
            True

        LoadMoreArticlesFailed ->
            False

        LikeInProgress _ ->
            True

        UnlikeInProgress _ ->
            True

        LikesActionFailed _ ->
            False


toLikesButton : Options msg -> Article -> LikesButton msg
toLikesButton options article =
    let
        count =
            String.fromInt (Article.likes article)

        description for =
            for ++ "-" ++ Article.title article

        authorButton profile_ =
            if Article.likedByMe profile_ article then
                UnlikeButton
                    { count = count
                    , description = description "unlike"
                    , msg = likeActionMsg options (UnLikeArticleClicked article)
                    }

            else
                LikeButton
                    { count = count
                    , description = description "like"
                    , msg = likeActionMsg options (LikeArticleClicked article)
                    }
    in
    case options.user of
        User.Guest ->
            GuestLikesButton { count = count }

        User.Author profile_ ->
            case options.feed.request of
                LikeInProgress id ->
                    if Article.id article == id then
                        LikeInProgressButton { count = count }

                    else
                        authorButton profile_

                UnlikeInProgress id ->
                    if Article.id article == id then
                        UnlikeInProgressButton { count = count }

                    else
                        authorButton profile_

                _ ->
                    authorButton profile_


likeActionMsg : Options msg -> Msg -> Maybe msg
likeActionMsg options msg =
    if requestIsInProgress options.feed.request then
        Nothing

    else
        Just (options.msg msg)


viewLikesButton : LikesButton msg -> Button msg
viewLikesButton button =
    case button of
        GuestLikesButton { count } ->
            Route.button Route.SignIn count
                |> Button.like

        UnlikeButton { msg, count, description } ->
            Button.maybe msg count
                |> Button.description description
                |> Button.like
                |> Button.solid

        LikeButton { msg, count, description } ->
            Button.maybe msg count
                |> Button.description description
                |> Button.like

        LikeInProgressButton { count } ->
            Button.decorative count
                |> Button.like
                |> Button.spinner
                |> Button.solid

        UnlikeInProgressButton { count } ->
            Button.decorative count
                |> Button.like
                |> Button.spinner


readMore : Article -> Element msg
readMore article =
    linkToArticle article (Text.label [] "READ MORE...")


articleSummary : Article -> Element msg
articleSummary article =
    linkToArticle article
        (column [ spacing Scale.small ]
            [ paragraph [] [ Text.subtitle [] (Article.title article) ]
            , paragraph [] [ Text.text [] (Article.about article) ]
            ]
        )


anchor : Article -> Attribute msg
anchor article =
    Anchor.description ("article-" ++ Article.title article)


profile : Article -> Element msg
profile article =
    authorLink article
        (row [ spacing Scale.small ]
            [ Avatar.large (Article.profileImage article)
            , column [ spacing Scale.small ]
                [ Text.link [ Text.green ] (Article.authorUsername article)
                , Text.date [] (Article.createdAt article)
                ]
            ]
        )


authorLink : Article -> Element msg -> Element msg
authorLink =
    Article.author >> Route.author >> Route.el


tags : Article -> Element msg
tags article =
    wrappedRow
        [ spacing Scale.small
        , paddingEach { edges | left = Scale.medium }
        ]
        (List.map viewTag (Article.tags article))


viewTag : Tag -> Element msg
viewTag t =
    Route.link (Route.tagFeed t) [] ("#" ++ Tag.value t)


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
