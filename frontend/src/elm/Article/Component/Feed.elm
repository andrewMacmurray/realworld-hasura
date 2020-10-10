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
import Effect exposing (Effect)
import Element exposing (..)
import Element.Anchor as Anchor
import Element.Avatar as Avatar
import Element.Background as Background
import Element.Border as Border
import Element.Button as Button
import Element.Divider as Divider
import Element.Loader as Loader
import Element.Palette as Palette
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
    { feed : Api.Data Feed }


type Msg
    = LoadFeedResponseReceived (Api.Response Feed)
    | UpdateArticleResponseReceived (Api.Response Article)
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article



-- Init


fromResponse : Api.Response { a | feed : Feed } -> Model
fromResponse =
    Api.fromResponse >> Api.mapData .feed >> init_


fromNullableResponse : Result error (Maybe { a | feed : Feed }) -> Model
fromNullableResponse =
    Api.fromNullableResponse >> Api.mapData .feed >> init_


load : SelectionSet Feed RootQuery -> ( Model, Effect Msg )
load selection =
    ( loading, Api.Articles.loadFeed selection LoadFeedResponseReceived )


loading : Model
loading =
    { feed = Api.Loading }


init_ : Api.Data Feed -> Model
init_ feed =
    { feed = feed
    }



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

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnLikeArticleClicked article ->
            ( model, unlikeArticle article )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | feed = Api.mapData (updateArticle article) model.feed }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
            ( model, Effect.none )


updateArticle : Article -> Feed -> Feed
updateArticle article feed =
    { feed | articles = Article.replace article feed.articles }


likeArticle : Article -> Effect Msg
likeArticle article =
    Api.Articles.like article UpdateArticleResponseReceived


unlikeArticle : Article -> Effect Msg
unlikeArticle article =
    Api.Articles.unlike article UpdateArticleResponseReceived



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
        (Loader.black
            { message = "Loading..."
            , visible = True
            }
        )


viewFeed : Options msg -> Feed -> Element msg
viewFeed options feed =
    column
        [ width fill
        , spacing Scale.extraLarge
        , paddingEach { edges | bottom = Scale.large }
        ]
        [ column
            [ spacing Scale.large, width fill ]
            (List.map (viewArticle options) feed.articles)
        , pages
        ]


pages =
    row [ spacing Scale.extraSmall ]
        [ activePage 1
        , page 2
        ]


activePage n =
    el
        [ width (px 25)
        , height (px 25)
        ]
        (el [ centerY, centerX ] (Text.text [ Text.black ] (String.fromInt n)))


page n =
    el
        [ Border.rounded 100
        , Background.color Palette.green
        , width (px 25)
        , height (px 25)
        ]
        (el [ centerY, centerX ] (Text.text [ Text.white ] (String.fromInt n)))


viewArticle : Options msg -> Article -> Element msg
viewArticle options article =
    column
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
