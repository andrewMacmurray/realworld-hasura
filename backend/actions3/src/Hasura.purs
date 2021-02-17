module Hasura
  ( Response
  , Error
  , query
  , mutation
  ) where

import Prelude
import Affjax.RequestHeader (RequestHeader(RequestHeader))
import Control.Monad.Except (ExceptT(..), withExceptT)
import Data.Either (Either)
import Effect.Aff (Aff)
import Env as Env
import GraphQLClient (GraphQLError, RequestOptions, Scope__RootMutation, Scope__RootQuery, SelectionSet, defaultRequestOptions, graphqlMutationRequest, graphqlQueryRequest)
import GraphQLClient as Graphql

type Response a
  = ExceptT Error Aff a

type Error
  = String

query :: forall a. SelectionSet Scope__RootQuery a -> Response a
query = graphqlQueryRequest Env.graphqlUrl options >>> toResponse

mutation :: forall a. SelectionSet Scope__RootMutation a -> Response a
mutation = graphqlMutationRequest Env.graphqlUrl options >>> toResponse

toResponse :: forall a. Aff (Either (GraphQLError a) a) -> Response a
toResponse = ExceptT >>> withExceptT Graphql.printGraphQLError

options :: RequestOptions
options = defaultRequestOptions { headers = [ adminSecret ] }

adminSecret :: RequestHeader
adminSecret = RequestHeader "x-hasura-admin-secret" Env.adminSecret
