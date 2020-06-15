module Api.Articles exposing
    ( all
    , articleSelection
    , byTag
    , followedByAuthor
    , like
    , load
    , loadArticle
    , loadFeed
    , newestFirst
    , publish
    , unlike
    )

import Api
import Api.Argument as Argument exposing (author, created_at, eq_, id, in_, order_by, tag, tags, where_)
import Api.Date as Date
import Article exposing (Article)
import Article.Author as Author exposing (Author)
import Effect exposing (Effect)
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.Enum.Order_by exposing (Order_by(..))
import Hasura.Enum.Tags_select_column as Tags_select_column
import Hasura.InputObject as Input exposing (Articles_insert_input, Articles_order_byOptionalFields)
import Hasura.Mutation
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles
import Hasura.Object.Comments as Comments
import Hasura.Object.Likes as Likes
import Hasura.Object.Likes_aggregate as LikesAggregate
import Hasura.Object.Likes_aggregate_fields as LikesAggregateFields
import Hasura.Object.Tags as Tags
import Hasura.Object.UnlikeResponse as UnlikeResponse
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments, TagsOptionalArguments)
import Tag exposing (Tag)
import User
import Utils.SelectionSet as SelectionSet



-- Article


loadArticle : Article.Id -> (Api.Response (Maybe Article) -> msg) -> Effect msg
loadArticle id msg =
    Hasura.Query.article { id = id } articleSelection
        |> Api.query msg
        |> Effect.loadArticle



--  Articles


load : SelectionSet (List Article) RootQuery -> (Api.Response (List Article) -> msg) -> Effect msg
load selection msg =
    selection
        |> Api.query msg
        |> Effect.loadArticles



-- Global Feed


loadFeed : SelectionSet (List Article) RootQuery -> (Api.Response Article.Feed -> msg) -> Effect msg
loadFeed articlesSelection_ msg =
    SelectionSet.succeed Article.Feed
        |> with articlesSelection_
        |> with popularTagsSelection
        |> Api.query msg
        |> Effect.loadFeed



-- By Tag


byTag : Tag -> SelectionSet (List Article) RootQuery
byTag tag =
    Hasura.Query.articles (newestFirst >> containsTag tag) articleSelection


containsTag : Tag -> ArticlesOptionalArguments -> ArticlesOptionalArguments
containsTag tag_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (tags Input.buildTags_bool_exp)
        (tag Input.buildString_comparison_exp)
        (eq_ (Tag.value tag_))



-- By Author


followedByAuthor : User.Profile -> SelectionSet (List Article) RootQuery
followedByAuthor profile =
    Hasura.Query.articles (newestFirst >> followedBy profile) articleSelection


followedBy : User.Profile -> ArticlesOptionalArguments -> ArticlesOptionalArguments
followedBy profile =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (author Input.buildUsers_bool_exp)
        (id Input.buildInt_comparison_exp)
        (in_ (User.id profile :: User.following profile))



-- Popular Tags


popularTagsSelection : SelectionSet (List Tag.Popular) RootQuery
popularTagsSelection =
    Hasura.Query.tags distinctAndLimit popularTagSelection
        |> SelectionSet.map (List.sortBy .count >> List.reverse)


distinctAndLimit : TagsOptionalArguments -> TagsOptionalArguments
distinctAndLimit args =
    { args | distinct_on = Present [ Tags_select_column.Tag ], limit = Present 20 }


popularTagSelection : SelectionSet Tag.Popular Hasura.Object.Tags
popularTagSelection =
    SelectionSet.succeed Tag.Popular
        |> with (SelectionSet.map Tag.one Tags.tag)
        |> with (SelectionSet.map (Maybe.withDefault 0) Tags.count)



-- Articles


all : SelectionSet (List Article) RootQuery
all =
    Hasura.Query.articles newestFirst articleSelection


articleSelection : SelectionSet Article Hasura.Object.Articles
articleSelection =
    SelectionSet.succeed Article.build
        |> with Articles.id
        |> with Articles.title
        |> with Articles.about
        |> with Articles.content
        |> with (Articles.author authorSelection)
        |> with (Date.fromScalar Articles.created_at)
        |> with (Articles.tags identity tagSelection)
        |> with (Articles.likes_aggregate identity likesCountSelection)
        |> with (Articles.likes identity likedBySelection)
        |> with (Articles.comments identity commentSelection)


commentSelection : SelectionSet Article.Comment Hasura.Object.Comments
commentSelection =
    SelectionSet.succeed Article.Comment
        |> with Comments.id
        |> with Comments.comment
        |> with (Date.fromScalar Comments.created_at)
        |> with (Comments.user authorSelection)


authorSelection : SelectionSet Author Hasura.Object.Users
authorSelection =
    SelectionSet.succeed Author.build
        |> with Users.id
        |> with Users.username
        |> with Users.profile_image


likedBySelection : SelectionSet Author Hasura.Object.Likes
likedBySelection =
    Likes.user
        (SelectionSet.succeed Author.build
            |> with Users.id
            |> with Users.username
            |> with Users.profile_image
        )


likesCountSelection : SelectionSet Int Hasura.Object.Likes_aggregate
likesCountSelection =
    LikesAggregate.aggregate (LikesAggregateFields.count identity)
        |> SelectionSet.map (Maybe.andThen identity >> Maybe.withDefault 0)


tagSelection : SelectionSet Tag.Tag Hasura.Object.Tags
tagSelection =
    SelectionSet.map Tag.one Tags.tag


newestFirst : ArticlesOptionalArguments -> ArticlesOptionalArguments
newestFirst =
    Argument.combine2 (order_by Input.buildArticles_order_by) (created_at Desc)



-- Publish


publish : (Api.Response () -> msg) -> Article.ToCreate -> Effect msg
publish msg article_ =
    Hasura.Mutation.publish_article identity { object = toPublishArgs article_ } SelectionSet.empty
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.publishArticle


toPublishArgs : Article.ToCreate -> Articles_insert_input
toPublishArgs article_ =
    Input.buildArticles_insert_input
        (\args ->
            { args
                | title = Present article_.title
                , about = Present article_.about
                , content = Present article_.content
                , tags = Present { data = List.map toTagArg article_.tags }
            }
        )


toTagArg : Tag.Tag -> { tag : OptionalArgument String }
toTagArg tag_ =
    { tag = Present (Tag.value tag_) }



-- Like


like : Article -> (Api.Response Article -> msg) -> Effect msg
like article msg =
    Hasura.Mutation.like_article { object = likeArticleArgs article } (Likes.article articleSelection)
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.likeArticle


likeArticleArgs : Article -> Input.Likes_insert_input
likeArticleArgs article =
    Input.buildLikes_insert_input (\args -> { args | article_id = Present (Article.id article) })



-- Unlike


unlike : Article -> (Api.Response Article -> msg) -> Effect msg
unlike article msg =
    Hasura.Mutation.unlike_article { article_id = Article.id article } (UnlikeResponse.article articleSelection)
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.unlikeArticle
