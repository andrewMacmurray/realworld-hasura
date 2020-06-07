module Element.Button.Follow exposing (button)

import Article.Author as Author exposing (Author)
import Element exposing (..)
import Element.Button as Button
import User exposing (User)



-- Follow Author Button


type alias Options msg =
    { user : User
    , onUnfollow : Author -> msg
    , onFollow : Author -> msg
    , author : Author
    }


button : Options msg -> Element msg
button { author, user, onUnfollow, onFollow } =
    case user of
        User.Guest ->
            none

        User.LoggedIn profile ->
            if User.equals profile author then
                none

            else if User.follows (Author.id author) profile then
                Button.button (onUnfollow author) "Unfollow"
                    |> Button.description ("unfollow-" ++ Author.username author)
                    |> Button.follow
                    |> Button.toElement

            else
                Button.button (onFollow author) "Follow"
                    |> Button.description ("follow-" ++ Author.username author)
                    |> Button.follow
                    |> Button.toElement
