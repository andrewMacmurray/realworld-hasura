module WebData exposing
    ( WebData(..)
    , fromResult
    , map
    )


type WebData data
    = Loading
    | Success data
    | Failure


map : (a -> b) -> WebData a -> WebData b
map f data =
    case data of
        Loading ->
            Loading

        Success a ->
            Success (f a)

        Failure ->
            Failure


fromResult : Result error data -> WebData data
fromResult res =
    case res of
        Ok data ->
            Success data

        Err _ ->
            Failure
