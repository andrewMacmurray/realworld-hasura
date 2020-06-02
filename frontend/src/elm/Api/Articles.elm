module Api.Articles exposing
    ( globalFeed
    , loadArticle
    , publish
    , tagFeed
    )

import Api
import Api.Argument as Argument exposing (created_at, eq_, order_by, tag, tags, where_)
import Api.Date as Date
import Article exposing (Article)
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
import Hasura.Object.Tags as Tags
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments, TagsOptionalArguments)
import Tag exposing (Tag)



-- Article


loadArticle : Article.Id -> (Api.Response (Maybe Article) -> msg) -> Effect msg
loadArticle id msg =
    Hasura.Query.article { id = id } articleSelection
        |> Api.query msg
        |> Effect.loadArticle



-- Global Feed


globalFeed : (Api.Response Article.Feed -> msg) -> Effect msg
globalFeed msg =
    globalFeedSelection
        |> Api.query msg
        |> Effect.loadGlobalFeed


globalFeedSelection : SelectionSet Article.Feed RootQuery
globalFeedSelection =
    SelectionSet.succeed Article.Feed
        |> with articlesSelection
        |> with popularTagsSelection



-- Tag Feed


tagFeed : Tag -> (Api.Response Article.Feed -> msg) -> Effect msg
tagFeed tag msg =
    tagFeedSelection tag
        |> Api.query msg
        |> Effect.loadTagFeed


tagFeedSelection : Tag -> SelectionSet Article.Feed RootQuery
tagFeedSelection tag =
    SelectionSet.succeed Article.Feed
        |> with (articlesByTagSelection tag)
        |> with popularTagsSelection


articlesByTagSelection : Tag -> SelectionSet (List Article) RootQuery
articlesByTagSelection tag =
    Hasura.Query.articles (newestFirst >> containsTag tag) articleSelection


containsTag : Tag -> ArticlesOptionalArguments -> ArticlesOptionalArguments
containsTag tag_ =
    Argument.combine4
        (where_ Input.buildArticles_bool_exp)
        (tags Input.buildTags_bool_exp)
        (tag Input.buildString_comparison_exp)
        (eq_ (Tag.value tag_))



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


articlesSelection : SelectionSet (List Article) RootQuery
articlesSelection =
    Hasura.Query.articles newestFirst articleSelection


articleSelection : SelectionSet Article Articles
articleSelection =
    SelectionSet.succeed Article.build
        |> with Articles.id
        |> with Articles.title
        |> with Articles.about
        |> with Articles.content
        |> with (Articles.author Users.username)
        |> with (Date.fromScalar Articles.created_at)
        |> with (Articles.tags identity tagSelection)


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
        |> failOnNothing
        |> Api.mutation msg
        |> Effect.publishArticle


toPublishArgs : Article.ToCreate -> Articles_insert_input
toPublishArgs article_ =
    { title = Present article_.title
    , about = Present article_.about
    , content = Present article_.content
    , tags = Present { data = List.map toTagArg article_.tags }
    }


toTagArg : Tag.Tag -> { tag : OptionalArgument String }
toTagArg tag_ =
    { tag = Present (Tag.value tag_) }


failOnNothing : SelectionSet (Maybe a) typeLock -> SelectionSet a typeLock
failOnNothing =
    SelectionSet.mapOrFail (Result.fromMaybe "required")
