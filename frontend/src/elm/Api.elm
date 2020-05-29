module Api exposing
    ( Mutation
    , Query
    , Response
    , doMutation
    , doQuery
    , map
    , mutation
    , query
    )

import Api.Token as Token
import Graphql.Http
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet exposing (SelectionSet)
import User exposing (User)



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


doMutation : User -> Mutation a msg -> Cmd msg
doMutation user { msg, selection } =
    selection
        |> Graphql.Http.mutationRequest endpoint
        |> authorizeForUser user
        |> Graphql.Http.send msg


doQuery : User -> Query a msg -> Cmd msg
doQuery user { msg, selection } =
    selection
        |> Graphql.Http.queryRequest endpoint
        |> authorizeForUser user
        |> Graphql.Http.send msg


authorizeForUser : User -> Graphql.Http.Request decodesTo -> Graphql.Http.Request decodesTo
authorizeForUser user request =
    case user of
        User.LoggedIn profile ->
            withAuthHeader request profile

        User.Guest ->
            request


withAuthHeader : Graphql.Http.Request decodesTo -> User.Profile -> Graphql.Http.Request decodesTo
withAuthHeader request profile =
    Graphql.Http.withHeader "Authorization" (bearerToken profile) request


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
