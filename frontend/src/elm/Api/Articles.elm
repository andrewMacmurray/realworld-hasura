module Api.Articles exposing (globalFeed, loadArticle, publish)

import Api
import Api.Date as Date
import Article exposing (Article)
import Effect exposing (Effect)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.Enum.Order_by exposing (Order_by(..))
import Hasura.InputObject as Input exposing (Articles_insert_input, Articles_order_byOptionalFields)
import Hasura.Mutation
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles
import Hasura.Object.Tags as Tags
import Hasura.Object.Users as Users
import Hasura.Query exposing (ArticlesOptionalArguments)
import Tag



-- Article


loadArticle : Article.Id -> (Api.Response (Maybe Article) -> msg) -> Effect msg
loadArticle id msg =
    Hasura.Query.article { id = id } articleSelection
        |> Api.query msg
        |> Effect.loadArticle



-- Global Feed


globalFeed : (Api.Response (List Article) -> msg) -> Effect msg
globalFeed msg =
    Hasura.Query.articles newestFirst articleSelection
        |> Api.query msg
        |> Effect.loadGlobalFeed


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
    orderBy (Input.buildArticles_order_by (created_at Desc))


orderBy : a -> { b | order_by : OptionalArgument (List a) } -> { b | order_by : OptionalArgument (List a) }
orderBy val args_ =
    { args_ | order_by = Present [ val ] }


created_at : a -> { b | created_at : OptionalArgument a } -> { b | created_at : OptionalArgument a }
created_at val args =
    { args | created_at = Present val }



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


failOnNothing =
    SelectionSet.mapOrFail (Result.fromMaybe "required")
