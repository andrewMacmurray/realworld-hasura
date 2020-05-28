module Api.Articles exposing (globalFeed)

import Api
import Api.Date as Date
import Article exposing (Article)
import Effect exposing (Effect)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.Object exposing (Articles)
import Hasura.Object.Articles as Articles
import Hasura.Object.Users as Users
import Hasura.Query


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
