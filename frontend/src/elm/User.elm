module User exposing
    ( Details
    , Id
    , Profile
    , SettingsUpdate
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
    , settingsUpdate
    , token
    , updateDetails
    , updateSettings
    , username
    )

import Api.Token exposing (Token)
import Article.Author as Author exposing (Author)
import Utils.List as List
import Utils.String as String



-- User


type User
    = Guest
    | Author Profile


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


type alias SettingsUpdate =
    { id : Id
    , username : String.NonEmpty
    , email : String.NonEmpty
    , bio : String.Optional
    , profileImage : String.Optional
    }



-- Construct


profile : Token -> Details -> Profile
profile =
    Profile_


settingsUpdate : Id -> String.NonEmpty -> String.NonEmpty -> String.Optional -> String.Optional -> SettingsUpdate
settingsUpdate =
    SettingsUpdate



-- Query


getProfile : User -> Maybe Profile
getProfile user =
    case user of
        Guest ->
            Nothing

        Author p ->
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


updateDetails : Profile -> Details -> User
updateDetails profile_ =
    profile (token profile_) >> Author


addFollowingId : Id -> User -> User
addFollowingId id_ =
    updateProfile_ (\p -> { p | following = id_ :: p.following })


removeFollowingId : Id -> User -> User
removeFollowingId id_ =
    updateProfile_ (\p -> { p | following = List.remove id_ p.following })


updateSettings : SettingsUpdate -> User -> User
updateSettings settings =
    updateProfile_
        (\profile_ ->
            { profile_
                | username = String.fromNonEmpty settings.username
                , email = String.fromNonEmpty settings.email
                , bio = String.fromOptional settings.bio
                , profileImage = String.fromOptional settings.profileImage
            }
        )


updateProfile_ : (Details -> Details) -> User -> User
updateProfile_ f user =
    case user of
        Guest ->
            Guest

        Author (Profile_ token_ details) ->
            Author (Profile_ token_ (f details))



-- Helpers


details_ : Profile -> Details
details_ (Profile_ _ d) =
    d
