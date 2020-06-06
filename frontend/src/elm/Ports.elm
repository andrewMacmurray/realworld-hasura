port module Ports exposing
    ( User
    , logout
    , saveUser
    , toLoggedIn
    , toProfile
    , toUser
    )

import Api.Token as Token
import User



-- User


type alias User =
    { username : String
    , email : String
    , token : String
    , bio : Maybe String
    , profileImage : Maybe String
    , following : List Int
    }


port saveUser : User -> Cmd msg


toUser : User.Profile -> User
toUser user =
    { username = User.username user
    , email = User.email user
    , token = Token.value (User.token user)
    , bio = User.bio user
    , profileImage = User.profileImage user
    , following = User.following user
    }


toLoggedIn : User -> User.User
toLoggedIn =
    User.LoggedIn << toProfile


toProfile : User -> User.Profile
toProfile u =
    User.profile (Token.token u.token)
        { username = u.username
        , email = u.email
        , bio = u.bio
        , profileImage = u.profileImage
        , following = u.following
        }



-- Logout


logout : Cmd msg
logout =
    logout_ ()


port logout_ : () -> Cmd msg
