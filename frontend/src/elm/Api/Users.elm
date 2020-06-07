module Api.Users exposing
    ( follow
    , signIn
    , signUp
    , unfollow
    )

import Api
import Api.Argument as Argument exposing (eq_, following_id)
import Api.Token as Token exposing (Token)
import Article
import Effect exposing (Effect)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..), with)
import Hasura.InputObject as Input
import Hasura.Mutation exposing (LoginRequiredArguments, SignupRequiredArguments)
import Hasura.Object
import Hasura.Object.Follows as Follows
import Hasura.Object.Follows_mutation_response as FollowsResponse
import Hasura.Object.TokenResponse as TokenResponse
import Hasura.Object.Users as Users
import User exposing (User)
import Utils.SelectionSet as SelectionSet



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



-- Follow


follow : Article.Author -> (Api.Response Int -> msg) -> Effect msg
follow author msg =
    Hasura.Mutation.follow_author { object = { following_id = Present author.id } } Follows.following_id
        |> SelectionSet.failOnNothing
        |> Api.mutation msg
        |> Effect.followAuthor



-- Unfollow


unfollow : Article.Author -> (Api.Response Int -> msg) -> Effect msg
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


equalsAuthor : Article.Author -> Input.Follows_bool_exp
equalsAuthor author =
    Input.buildFollows_bool_exp
        (Argument.combine2
            (following_id Input.buildInt_comparison_exp)
            (eq_ author.id)
        )



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
