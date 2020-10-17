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
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Button as Button
import Element.Divider as Divider
import Element.Keyed as Keyed
import Element.Loader as Loader
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
    , loadMoreRequest : LoadMoreRequest
    , selection : FeedSelection
    }


type alias FeedSelection =
    Page.Number -> SelectionSet Feed RootQuery


type Msg
    = LoadFeedResponseReceived (Api.Response Feed)
    | LoadMoreResponseReceived (Api.Response Feed)
    | LoadMoreClicked
    | UpdateArticleResponseReceived (Api.Response Article)
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article


type LoadMoreRequest
    = Idle
    | Loading
    | Failure



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
    , loadMoreRequest = Idle
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
            ( { model | loadMoreRequest = Loading }, loadMore model )

        LoadMoreResponseReceived (Ok feed) ->
            ( { model
                | loadMoreRequest = Idle
                , feed = appendToFeed feed model.feed
                , page = Page.next model.page
              }
            , Effect.none
            )

        LoadMoreResponseReceived (Err _) ->
            ( { model | loadMoreRequest = Failure }, Effect.none )

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnLikeArticleClicked article ->
            ( model, unlikeArticle article )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | feed = Api.mapData (updateArticle article) model.feed }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
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
    Api.Articles.like article UpdateArticleResponseReceived


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article UpdateArticleResponseReceived


loadMore : Model -> Effect Msg
loadMore model =
    Api.Articles.loadFeed (model.selection (Page.next model.page)) LoadMoreResponseReceived



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
        (Loader.iconWithMessage "Loading..."
            |> Loader.alignLeft
            |> Loader.black
            |> Loader.show True
        )


viewFeed : Options msg -> Feed -> Element msg
viewFeed options feed =
    column
        [ width fill
        , spacing Scale.extraLarge
        , paddingEach { edges | bottom = Scale.large }
        ]
        [ Keyed.column [ spacing Scale.large, width fill ] (List.map (viewArticle options) feed.articles)
        , Element.map options.msg (pages options feed)
        ]


pages : Options msg -> Feed -> Element Msg
pages options feed =
    Page.view
        { total = feed.count
        , loading = isLoadingMore options.feed.loadMoreRequest
        , page = options.feed.page
        , onClick = LoadMoreClicked
        }


isLoadingMore : LoadMoreRequest -> Bool
isLoadingMore request =
    case request of
        Loading ->
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


likes : Options msg -> Article -> Element msg
likes options article =
    let
        likeCount =
            Article.likes article |> String.fromInt
    in
    el [ alignRight, alignTop ]
        (case options.user of
            User.Guest ->
                Route.button Route.SignIn likeCount
                    |> Button.like
                    |> Button.toElement

            User.Author profile_ ->
                if Article.likedByMe profile_ article then
                    Button.button (options.msg <| UnLikeArticleClicked article) likeCount
                        |> Button.description ("unlike-" ++ Article.title article)
                        |> Button.like
                        |> Button.solid
                        |> Button.toElement

                else
                    Button.button (options.msg <| LikeArticleClicked article) likeCount
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
