module Api.Users exposing
    ( signIn
    , signUp
    )

import Api
import Api.Token as Token exposing (Token)
import Effect exposing (Effect)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet(..), with)
import Hasura.Mutation exposing (LoginRequiredArguments, SignupRequiredArguments)
import Hasura.Object exposing (User_profile)
import Hasura.Object.TokenResponse
import User exposing (User)


signUp : SignupRequiredArguments -> (Api.Response User.Profile -> msg) -> Effect msg
signUp inputs msg =
    Hasura.Mutation.signup inputs userSelection
        |> Api.mutation msg
        |> Effect.signUp


signIn : LoginRequiredArguments -> (Api.Response User.Profile -> msg) -> Effect msg
signIn inputs msg =
    Hasura.Mutation.login inputs userSelection
        |> Api.mutation msg
        |> Effect.signIn


userSelection : SelectionSet User.Profile Hasura.Object.TokenResponse
userSelection =
    SelectionSet.succeed User.profile
        |> with tokenSelection
        |> with Hasura.Object.TokenResponse.username
        |> with Hasura.Object.TokenResponse.email


tokenSelection : SelectionSet Token Hasura.Object.TokenResponse
tokenSelection =
    SelectionSet.map Token.token Hasura.Object.TokenResponse.token
