module Api.Token exposing
    ( Token
    , token
    , value
    )


type Token
    = Token String


token : String -> Token
token =
    Token


value : Token -> String
value (Token raw) =
    raw
