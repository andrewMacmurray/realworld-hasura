module Api exposing
    ( Response
    , mutate
    )

import Graphql.Http
import Graphql.Operation exposing (RootMutation)
import Graphql.SelectionSet exposing (SelectionSet)


type alias Response a =
    Result (Graphql.Http.Error a) a


mutate : (Response decodesTo -> msg) -> SelectionSet decodesTo RootMutation -> Cmd msg
mutate msg selectionSet =
    selectionSet
        |> Graphql.Http.mutationRequest endpoint
        |> Graphql.Http.send msg


endpoint =
    "http://localhost:8080/v1/graphql"
