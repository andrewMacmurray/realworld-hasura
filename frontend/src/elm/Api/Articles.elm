module Api.Articles exposing (globalFeed)

import Api
import Article exposing (Article)
import Effect exposing (Effect)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles
import Hasura.Query


globalFeed : (Api.Response (List Article) -> msg) -> Effect msg
globalFeed msg =
    Hasura.Query.articles identity articleSelection
        |> Effect.loadGlobalFeed msg


articleSelection : SelectionSet Article Articles
articleSelection =
    SelectionSet.succeed Article.build
        |> SelectionSet.with Articles.title
        |> SelectionSet.with Articles.about
