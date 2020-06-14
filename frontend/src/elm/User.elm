module User exposing
    ( Details
    , Id
    , Profile
    , User(..)
    , addFollowingId
    , bio
    , email
    , equals
    , following
    , follows
    , getProfile
    , id
    , profile
    , profileImage
    , removeFollowingId
    , token
    , username
    )

import Api.Token exposing (Token)
import Article.Author as Author exposing (Author)
import Utils.List as List



-- User


type User
    = Guest
    | LoggedIn Profile


type Profile
    = Profile_ Token Details


type alias Details =
    { id : Id
    , username : String
    , email : String
    , bio : Maybe String
    , profileImage : Maybe String
    , following : List Id
    }


type alias Id =
    Int



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


id : Profile -> Id
id =
    details_ >> .id


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
    details_
        >> .profileImage


following : Profile -> List Id
following =
    details_ >> .following


follows : Int -> Profile -> Bool
follows id_ profile_ =
    List.member id_ (following profile_)


equals : Profile -> Author -> Bool
equals p a =
    id p == Author.id a



-- Update


addFollowingId : Id -> User -> User
addFollowingId id_ =
    updateProfile (\p -> { p | following = id_ :: p.following })


removeFollowingId : Id -> User -> User
removeFollowingId id_ =
    updateProfile (\p -> { p | following = List.remove id_ p.following })


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
