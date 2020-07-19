module User.Element exposing
    ( showIfLoggedIn
    , showIfMe
    )

import Article.Author exposing (Author)
import Element exposing (Element)
import User exposing (User)


showIfLoggedIn : Element msg -> User -> Element msg
showIfLoggedIn element user =
    case user of
        User.Guest ->
            Element.none

        User.Author _ ->
            element


showIfMe : Element msg -> User -> Author -> Element msg
showIfMe element user author =
    case user of
        User.Guest ->
            Element.none

        User.Author profile ->
            if User.equals profile author then
                element

            else
                Element.none
