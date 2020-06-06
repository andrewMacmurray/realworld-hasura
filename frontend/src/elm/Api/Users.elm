module Api.Users exposing
    ( signIn
    , signUp
    )

import Api
import Api.Token as Token exposing (Token)
import Effect exposing (Effect)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..), with)
import Hasura.Mutation exposing (LoginRequiredArguments, SignupRequiredArguments)
import Hasura.Object
import Hasura.Object.Follows as Follows
import Hasura.Object.TokenResponse as TokenResponse
import Hasura.Object.Users as Users
import User exposing (User)



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



-- Selections


userSelection : SelectionSet User.Profile Hasura.Object.TokenResponse
userSelection =
    SelectionSet.succeed User.profile
        |> with tokenSelection
        |> with detailsSelection


detailsSelection : SelectionSet User.Details Hasura.Object.TokenResponse
detailsSelection =
    SelectionSet.succeed User.Details
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
