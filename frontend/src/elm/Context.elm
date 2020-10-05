module Context exposing
    ( Context
    , closeMenu
    , init
    , openMenu
    , setUser
    , updateUser
    )

import Element.Layout.Menu as Menu exposing (Menu)
import Ports
import User exposing (User)



-- Context


type alias Context =
    { user : User
    , menu : Menu
    }



-- Init


init : Maybe Ports.User -> Context
init user =
    { menu = Menu.Closed
    , user = userFromFlags user
    }


userFromFlags : Maybe Ports.User -> User
userFromFlags =
    Maybe.map Ports.toLoggedIn >> Maybe.withDefault User.Guest



-- Update


setUser : User -> Context -> Context
setUser user =
    updateUser (always user)


updateUser : (User -> User) -> Context -> Context
updateUser toUser context =
    { context | user = toUser context.user }


openMenu : Context -> Context
openMenu context =
    { context | menu = Menu.Open }


closeMenu : Context -> Context
closeMenu context =
    { context | menu = Menu.Closed }
