module Api.Authors exposing (get)

import Api
import Api.Articles as Articles
import Article
import Effect exposing (Effect)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Hasura.Object exposing (Users)
import Hasura.Object.Users as Users
import Hasura.Query



-- Get Author


get : Int -> (Api.Response (Maybe Article.Author) -> msg) -> Effect msg
get id_ msg =
    Hasura.Query.user { id = id_ } authorSelection
        |> Api.query msg
        |> Effect.getAuthor


authorSelection : SelectionSet Article.Author Users
authorSelection =
    SelectionSet.succeed Article.Author
        |> with Users.id
        |> with Users.username
        |> with Users.profile_image
        |> with (Users.articles identity Articles.articleSelection)
