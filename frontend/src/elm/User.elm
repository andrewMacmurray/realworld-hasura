module User exposing
    ( Details
    , Profile
    , User(..)
    , bio
    , email
    , following
    , profile
    , profileImage
    , token
    , username
    )

import Api.Token exposing (Token)



-- User


type User
    = Guest
    | LoggedIn Profile


type Profile
    = Profile_ Token Details


type alias Details =
    { username : String
    , email : String
    , bio : Maybe String
    , profileImage : Maybe String
    , following : List Int
    }



-- Construct


profile : Token -> Details -> Profile
profile =
    Profile_



-- Query


token : Profile -> Token
token (Profile_ token_ _) =
    token_


username : Profile -> String
username =
    details_ >> .username


email : Profile -> String
email =
    details_ >> .email


bio : Profile -> Maybe String
bio =
    details_ >> .bio


profileImage : Profile -> Maybe String
profileImage =
    details_ >> .profileImage


following : Profile -> List Int
following =
    details_ >> .following



-- Helpers


details_ : Profile -> Details
details_ (Profile_ _ d) =
    d
