module Api.Users exposing
    ( follow
    , refresh
    , signIn
    , signUp
    , unfollow
    , update
    )

import Api
import Api.Argument as Argument exposing (eq_, following_id)
import Api.Token as Token exposing (Token)
import Article.Author as Author exposing (Author)
import Effect exposing (Effect)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..), with)
import Hasura.InputObject as Input
import Hasura.Mutation exposing (LoginRequiredArguments, SignupRequiredArguments, UpdateUserOptionalArguments)
import Hasura.Object
import Hasura.Object.Follows as Follows
import Hasura.Object.Follows_mutation_response as FollowsResponse
import Hasura.Object.Profile as Profile
import Hasura.Object.TokenResponse as TokenResponse
import Hasura.Object.Users as Users
import Hasura.Query
import User exposing (User)
import Utils.SelectionSet as SelectionSet exposing (failOnNothing)



-- Sign Up


signUp : SignupRequiredArguments -> (Api.Response User.Profile -> msg) -> Effect msg
signUp inputs msg =
    Hasura.Mutation.signup inputs userSelection
        |> Api.mutation msg
        |> Effect.signUp



-- Sign In


signIn : LoginRequiredArguments -> (Api.Response User.Profile -> msg) -> Effect msg
signIn inputs msg =
    Hasura.Mutation.login inputs userSelection
        |> Api.mutation msg
        |> Effect.signIn



-- Refresh User


refresh : User -> (Api.Response User -> msg) -> Effect msg
refresh user msg =
    case user of
        User.Guest ->
            Effect.none

        User.Author profile ->
            refreshUser profile msg


refreshUser : User.Profile -> (Api.Response User -> msg) -> Effect msg
refreshUser profile msg =
    Hasura.Query.profile identity (loggedInUserSelection profile)
        |> SelectionSet.map List.head
        |> SelectionSet.failOnNothing
        |> Api.query msg
        |> Effect.refreshUser


loggedInUserSelection : User.Profile -> SelectionSet User Hasura.Object.Profile
loggedInUserSelection profile =
    SelectionSet.map (User.updateDetails profile) detailsSelection_


detailsSelection_ : SelectionSet User.Details Hasura.Object.Profile
detailsSelection_ =
    SelectionSet.succeed User.Details
        |> with_ Profile.user_id
        |> with_ Profile.username
        |> with_ Profile.email
        |> with Profile.bio
        |> with Profile.profile_image
        |> with followsSelection_


followsSelection_ : SelectionSet (List Int) Hasura.Object.Profile
followsSelection_ =
    Profile.follows identity (Follows.user Users.id)


with_ : SelectionSet (Maybe a) typeLock -> SelectionSet (a -> b) typeLock -> SelectionSet b typeLock
with_ =
    with << failOnNothing



-- Follow


follow : Author -> (Api.Response Int -> msg) -> Effect msg
follow author msg =
    Hasura.Mutation.follow_author { object = { following_id = Present (Author.id author) } } Follows.following_id
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.followAuthor



-- Unfollow


unfollow : Author -> (Api.Response Int -> msg) -> Effect msg
unfollow author msg =
    Hasura.Mutation.unfollow_authors { where_ = equalsAuthor author } unfollowSelection
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.unfollowAuthor


unfollowSelection : SelectionSet Int Hasura.Object.Follows_mutation_response
unfollowSelection =
    FollowsResponse.returning Follows.following_id
        |> SelectionSet.map List.head
        |> SelectionSet.failOnNothing


equalsAuthor : Author -> Input.Follows_bool_exp
equalsAuthor author =
    Input.buildFollows_bool_exp
        (Argument.combine2
            (following_id Input.buildInt_comparison_exp)
            (eq_ (Author.id author))
        )



-- Update


update : User.SettingsUpdate -> (Api.Response () -> msg) -> Effect msg
update settings msg =
    Hasura.Mutation.update_user (updateUserArgs settings) { pk_columns = { id = settings.id } } SelectionSet.empty
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.mutateSettings


updateUserArgs : User.SettingsUpdate -> UpdateUserOptionalArguments -> UpdateUserOptionalArguments
updateUserArgs settings args =
    { args
        | set_ =
            Present
                { username = Argument.fromNonEmpty settings.username
                , email = Argument.fromNonEmpty settings.email
                , bio = Argument.fromOptional settings.bio
                , profile_image = Argument.fromOptional settings.profileImage
                }
    }



-- Selections


userSelection : SelectionSet User.Profile Hasura.Object.TokenResponse
userSelection =
    SelectionSet.succeed User.profile
        |> with tokenSelection
        |> with detailsSelection


detailsSelection : SelectionSet User.Details Hasura.Object.TokenResponse
detailsSelection =
    SelectionSet.succeed User.Details
        |> with TokenResponse.user_id
        |> with TokenResponse.username
        |> with TokenResponse.email
        |> with TokenResponse.bio
        |> with TokenResponse.profile_image
        |> with followsSelection


followsSelection : SelectionSet (List Int) Hasura.Object.TokenResponse
followsSelection =
    TokenResponse.follows (Follows.user Users.id)
        |> SelectionSet.map flattenMaybes


flattenMaybes : Maybe (List (Maybe a)) -> List a
flattenMaybes =
    Maybe.withDefault [] >> List.filterMap identity


tokenSelection : SelectionSet Token Hasura.Object.TokenResponse
tokenSelection =
    SelectionSet.map Token.token TokenResponse.token
