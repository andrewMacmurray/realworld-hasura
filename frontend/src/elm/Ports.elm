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
    }


port saveUser : User -> Cmd msg


toUser : User.Profile -> User
toUser user =
    { username = User.username user
    , email = User.email user
    , token = Token.value (User.token user)
    }


toLoggedIn : User -> User.User
toLoggedIn =
    User.LoggedIn << toProfile


toProfile : User -> User.Profile
toProfile u =
    User.profile (Token.token u.token) u.username u.email



-- Logout


logout : Cmd msg
logout =
    logout_ ()


port logout_ : () -> Cmd msg
