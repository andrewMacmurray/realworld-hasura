module User exposing
    ( Profile
    , User(..)
    , email
    , profile
    , token
    , username
    )

import Api.Token exposing (Token)


type User
    = Guest
    | LoggedIn Profile


type Profile
    = Profile_ Token Details_


type alias Details_ =
    { username : String
    , email : String
    }


profile : Token -> String -> String -> Profile
profile token_ username_ email_ =
    Profile_ token_
        { username = username_
        , email = email_
        }


token : Profile -> Token
token (Profile_ token_ _) =
    token_


username : Profile -> String
username (Profile_ _ p) =
    p.username


email : Profile -> String
email (Profile_ _ p) =
    p.email
