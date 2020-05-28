port module Ports exposing
    ( logout
    , saveToken
    )


port saveToken : String -> Cmd msg


logout : Cmd msg
logout =
    clearToken_ ()


port clearToken_ : () -> Cmd msg
