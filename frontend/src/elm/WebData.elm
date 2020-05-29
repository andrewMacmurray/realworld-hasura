module WebData exposing
    ( WebData(..)
    , fromResult
    )


type WebData data
    = Loading
    | Success data
    | Failure


fromResult : Result error data -> WebData data
fromResult res =
    case res of
        Ok data ->
            Success data

        Err _ ->
            Failure
