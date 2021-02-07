module Api.Object.ProfileStddevPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileStddevPopFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileStddevPopFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
