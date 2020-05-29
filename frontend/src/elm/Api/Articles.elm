module Api.Articles exposing (globalFeed, publish)

import Api
import Api.Date as Date
import Article exposing (Article)
import Effect exposing (Effect)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.InputObject exposing (Articles_insert_input)
import Hasura.Mutation
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles
import Hasura.Object.Users as Users
import Hasura.Query
import Tags
import User



-- Global Feed


globalFeed : (Api.Response (List Article) -> msg) -> Effect msg
globalFeed msg =
    Hasura.Query.articles identity articleSelection
        |> Api.query msg
        |> Effect.loadGlobalFeed


articleSelection : SelectionSet Article Articles
articleSelection =
    SelectionSet.succeed Article.build
        |> with Articles.title
        |> with Articles.about
        |> with (Articles.author Users.username)
        |> with (Date.fromScalar Articles.created_at)



-- Publish


publish : User.Profile -> (Api.Response () -> msg) -> Article.ToCreate -> Effect msg
publish user msg article_ =
    Hasura.Mutation.publish_article identity { object = toPublishArgs article_ } SelectionSet.empty
        |> failOnNothing
        |> Api.mutation msg
        |> Effect.publishArticle user


toPublishArgs : Article.ToCreate -> Articles_insert_input
toPublishArgs article_ =
    { title = Present article_.title
    , about = Present article_.about
    , content = Present article_.content
    , tags = Present { data = List.map toTagArg article_.tags }
    }


toTagArg tag_ =
    { tag = Present (Tags.value tag_) }


failOnNothing =
    SelectionSet.mapOrFail (Result.fromMaybe "required")
