module Api.Users exposing
    ( signIn
    , signUp
    )

import Api
import Effect exposing (Effect)
import Hasura.Mutation exposing (LoginRequiredArguments, SignupRequiredArguments)
import Hasura.Object.Token


signUp : SignupRequiredArguments -> (Api.Response String -> msg) -> Effect msg
signUp inputs msg =
    Hasura.Mutation.signup inputs Hasura.Object.Token.token |> Effect.signUp msg


signIn : LoginRequiredArguments -> (Api.Response String -> msg) -> Effect msg
signIn inputs msg =
    Hasura.Mutation.login inputs Hasura.Object.Token.token |> Effect.signIn msg
