module WebData exposing
    ( WebData(..)
    , fromResult
    )


type WebData data
    = Loading
    | Loaded data
    | Failure


fromResult : Result error data -> WebData data
fromResult res =
    case res of
        Ok data ->
            Loaded data

        Err _ ->
            Failure
