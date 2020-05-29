module Api exposing
    ( Mutation
    , Query
    , Response
    , authenticatedMutation
    , guestMutation
    , guestQuery
    , map
    , mutation
    , query
    )

import Api.Token as Token
import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import User



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


guestMutation : Mutation a msg -> Cmd msg
guestMutation { msg, selection } =
    selection
        |> Graphql.Http.mutationRequest endpoint
        |> Graphql.Http.send msg


guestQuery : Query a msg -> Cmd msg
guestQuery { msg, selection } =
    selection
        |> Graphql.Http.queryRequest endpoint
        |> Graphql.Http.send msg


authenticatedMutation : User.Profile -> Mutation a msg -> Cmd msg
authenticatedMutation profile { msg, selection } =
    selection
        |> Graphql.Http.mutationRequest endpoint
        |> Graphql.Http.withHeader "Authorization" (bearerToken profile)
        |> Graphql.Http.send msg


bearerToken : User.Profile -> String
bearerToken =
    User.token >> Token.value >> prepend "Bearer "


prepend : String -> String -> String
prepend str s =
    str ++ s



-- Endpoint


endpoint : String
endpoint =
    "http://localhost:8080/v1/graphql"
