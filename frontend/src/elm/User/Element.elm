module User.Element exposing (showIfLoggedIn)

import Element exposing (Element)
import User exposing (User)


showIfLoggedIn : Element msg -> User -> Element msg
showIfLoggedIn element user =
    case user of
        User.Guest ->
            Element.none

        User.Author _ ->
            element
