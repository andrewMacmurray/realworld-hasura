module Hasura
  ( Response
  , query
  , mutation
  ) where

import Affjax.RequestHeader (RequestHeader(RequestHeader))
import Data.Either (Either)
import Effect.Aff (Aff)
import Env as Env
import GraphQLClient
  ( GraphQLError
  , RequestOptions
  , Scope__RootMutation
  , Scope__RootQuery
  , SelectionSet
  , defaultRequestOptions
  , graphqlMutationRequest
  , graphqlQueryRequest
  )

type Response a
  = Aff (Either (GraphQLError a) a)

query :: forall a. SelectionSet Scope__RootQuery a -> Response a
query = graphqlQueryRequest Env.graphqlUrl options

mutation :: forall a. SelectionSet Scope__RootMutation a -> Response a
mutation = graphqlMutationRequest Env.graphqlUrl options

options :: RequestOptions
options = defaultRequestOptions { headers = [ adminSecret ] }

adminSecret :: RequestHeader
adminSecret = RequestHeader "x-hasura-admin-secret" Env.adminSecret
