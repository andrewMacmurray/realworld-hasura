module Article.Author.Follow exposing
    ( Msg
    , button
    , effect
    )

import Api
import Api.Users
import Article.Author as Author exposing (Author)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Button as Button
import User exposing (User)



-- Types


type Msg
    = FollowClicked Author
    | UnfollowClicked Author
    | FollowResponseReceived (Api.Response Author.Id)
    | UnfollowResponseReceived (Api.Response Author.Id)



-- Effect


effect : Msg -> Effect Msg
effect msg =
    case msg of
        FollowClicked author ->
            followAuthor author

        UnfollowClicked author ->
            unfollowAuthor author

        FollowResponseReceived (Ok id) ->
            Effect.addToUserFollows id

        FollowResponseReceived (Err _) ->
            Effect.none

        UnfollowResponseReceived (Ok id) ->
            Effect.removeFromUserFollows id

        UnfollowResponseReceived (Err _) ->
            Effect.none


followAuthor : Author -> Effect Msg
followAuthor author_ =
    Api.Users.follow author_ FollowResponseReceived


unfollowAuthor : Author -> Effect Msg
unfollowAuthor author_ =
    Api.Users.unfollow author_ UnfollowResponseReceived



-- Follow Button


type alias Options msg =
    { user : User
    , author : Author
    , msg : Msg -> msg
    }


button : Options msg -> Element msg
button { author, user, msg } =
    case user of
        User.Guest ->
            none

        User.LoggedIn profile ->
            if User.equals profile author then
                none

            else if User.follows (Author.id author) profile then
                Button.button (msg <| UnfollowClicked author) "Unfollow"
                    |> Button.description ("unfollow-" ++ Author.username author)
                    |> Button.follow
                    |> Button.toElement

            else
                Button.button (msg <| FollowClicked author) "Follow"
                    |> Button.description ("follow-" ++ Author.username author)
                    |> Button.follow
                    |> Button.toElement
