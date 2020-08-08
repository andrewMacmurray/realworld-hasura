module Article.Feed exposing
    ( Model
    , Msg
    , embed
    , failure
    , load
    , loaded
    , loading
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
import Element.Button as Button
import Element.Divider as Divider
import Element.Scale as Scale exposing (edges)
import Element.Text as Text
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import Route
import Tag exposing (Tag)
import User exposing (User)
import Utils.Update as Update
import WebData exposing (WebData)



-- Page Model


type alias PageModel model =
    { model | feed : Model }


type alias PageMsg msg =
    Msg -> msg



-- Model


type alias Model =
    { articles : WebData (List Article)
    }


type Msg
    = LoadArticlesResponseReceived (Api.Response (List Article))
    | UpdateArticleResponseReceived (Api.Response Article)
    | LikeArticleClicked Article
    | UnLikeArticleClicked Article



-- Init


loaded : List Article -> Model
loaded articles =
    { articles = WebData.Success articles
    }


failure : Model
failure =
    { articles = WebData.Failure
    }


load : SelectionSet (List Article) RootQuery -> ( Model, Effect Msg )
load selection =
    ( loading, Api.Articles.load selection LoadArticlesResponseReceived )


loading : Model
loading =
    { articles = WebData.Loading
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
        LoadArticlesResponseReceived response ->
            ( { model | articles = WebData.fromResult response }, Effect.none )

        LikeArticleClicked article ->
            ( model, likeArticle article )

        UnLikeArticleClicked article ->
            ( model, unlikeArticle article )

        UpdateArticleResponseReceived (Ok article) ->
            ( { model | articles = WebData.map (Article.replace article) model.articles }, Effect.none )

        UpdateArticleResponseReceived (Err _) ->
            ( model, Effect.none )


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
    case options.feed.articles of
        WebData.Loading ->
            Text.text [] "Loading Feed"

        WebData.Success articles ->
            column
                [ spacing Scale.large
                , width fill
                ]
                (List.map (viewArticle options) articles)

        WebData.Failure ->
            Text.error [] "Something went wrong"


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
                , row [ width fill ] [ readMore article, tags article ]
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
                Button.decorative likeCount
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
    el [ width fill, alignBottom ]
        (wrappedRow
            [ spacing Scale.small
            , alignRight
            , paddingEach { edges | left = Scale.medium }
            ]
            (List.map viewTag (Article.tags article))
        )


viewTag : Tag -> Element msg
viewTag t =
    Route.link (Route.tagFeed t) [] ("#" ++ Tag.value t)


linkToArticle : Article -> Element msg -> Element msg
linkToArticle =
    Article.id >> Route.Article >> Route.el
