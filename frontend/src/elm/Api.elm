module Api exposing
    ( Mutation
    , Query
    , Response
    , map
    , mutation
    , mutationRequest
    , query
    , queryRequest
    )

import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)



-- Api


type alias Response a =
    Result (Graphql.Http.Error a) a


type alias Mutation a msg =
    { msg : Response a -> msg
    , selection : SelectionSet a RootMutation
    }


type alias Query a msg =
    { msg : Response a -> msg
    , selection : SelectionSet a RootQuery
    }



-- Construct


query : (Response a -> msg) -> SelectionSet a RootQuery -> Query a msg
query =
    Query


mutation : (Response a -> msg) -> SelectionSet a RootMutation -> Mutation a msg
mutation =
    Mutation



-- Transform


map :
    (msgA -> msgB)
    -> { msg : Response a -> msgA, selection : b }
    -> { msg : Response a -> msgB, selection : b }
map toMsg m =
    { msg = toMsg << m.msg
    , selection = m.selection
    }



-- Do Request


mutationRequest : Mutation a msg -> Cmd msg
mutationRequest { msg, selection } =
    selection
        |> Graphql.Http.mutationRequest endpoint
        |> Graphql.Http.send msg


queryRequest : Query a msg -> Cmd msg
queryRequest { msg, selection } =
    selection
        |> Graphql.Http.queryRequest endpoint
        |> Graphql.Http.send msg



-- Endpoint


endpoint : String
endpoint =
    "http://localhost:8080/v1/graphql"
