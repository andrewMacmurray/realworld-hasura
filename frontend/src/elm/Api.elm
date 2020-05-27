module Api exposing
    ( Response
    , mutate
    , query
    )

import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)


type alias Response a =
    Result (Graphql.Http.Error a) a


mutate : (Response decodesTo -> msg) -> SelectionSet decodesTo RootMutation -> Cmd msg
mutate msg selectionSet =
    selectionSet
        |> Graphql.Http.mutationRequest endpoint
        |> Graphql.Http.send msg


query : (Response decodesTo -> msg) -> SelectionSet decodesTo RootQuery -> Cmd msg
query msg selectionSet =
    selectionSet
        |> Graphql.Http.queryRequest endpoint
        |> Graphql.Http.send msg


endpoint =
    "http://localhost:8080/v1/graphql"
