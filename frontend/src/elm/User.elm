module User exposing
    ( Profile
    , User(..)
    , fromToken
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


fromToken : Maybe String -> User
fromToken =
    Maybe.map LoggedIn >> Maybe.withDefault Guest
