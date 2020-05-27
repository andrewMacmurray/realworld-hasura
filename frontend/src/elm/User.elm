module User exposing
    ( Profile
    , User(..)
    , login
    )


type User
    = Guest
    | LoggedIn Profile


type alias Profile =
    String


login : String -> User
login =
    LoggedIn
