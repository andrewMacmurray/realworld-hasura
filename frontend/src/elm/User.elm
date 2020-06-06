module User exposing
    ( Details
    , Profile
    , User(..)
    , addFollowingId
    , bio
    , email
    , following
    , follows
    , getProfile
    , profile
    , profileImage
    , removeFollowingId
    , token
    , username
    )

import Api.Token exposing (Token)
import Utils.List as List



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


getProfile : User -> Maybe Profile
getProfile user =
    case user of
        Guest ->
            Nothing

        LoggedIn p ->
            Just p


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


follows : Int -> Profile -> Bool
follows id profile_ =
    List.member id (following profile_)



-- Update


addFollowingId : Int -> User -> User
addFollowingId id =
    updateProfile (\p -> { p | following = id :: p.following })


removeFollowingId : Int -> User -> User
removeFollowingId id =
    updateProfile (\p -> { p | following = List.remove id p.following })


updateProfile : (Details -> Details) -> User -> User
updateProfile f user =
    case user of
        Guest ->
            Guest

        LoggedIn (Profile_ token_ details) ->
            LoggedIn (Profile_ token_ (f details))



-- Helpers


details_ : Profile -> Details
details_ (Profile_ _ d) =
    d
