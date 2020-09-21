module Api exposing
    ( Data(..)
    , Mutation
    , Query
    , Response
    , doMutation
    , doQuery
    , errorMessage
    , fromNullableResponse
    , fromResponse
    , map
    , mapData
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



-- Data


type Data a
    = Loading
    | Success a
    | NotFound
    | Failure


fromResponse : Response a -> Data a
fromResponse =
    Result.map Success >> Result.withDefault Failure


fromNullableResponse : Result error (Maybe a) -> Data a
fromNullableResponse res =
    case res of
        Ok (Just a) ->
            Success a

        Ok Nothing ->
            NotFound

        Err _ ->
            Failure


mapData : (a -> b) -> Data a -> Data b
mapData f data =
    case data of
        Success a ->
            Success (f a)

        Loading ->
            Loading

        NotFound ->
            NotFound

        Failure ->
            Failure



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



-- Errors


errorMessage : Graphql.Http.Error a -> String
errorMessage err =
    case err of
        Graphql.Http.GraphqlError _ errors ->
            errors |> List.map .message |> String.join ", "

        Graphql.Http.HttpError _ ->
            "http error"



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
        User.Author profile ->
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
    "https://realworld-hasura.herokuapp.com/v1/graphql"
