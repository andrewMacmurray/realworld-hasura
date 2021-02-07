module Api.Object.ProfileVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileVarianceFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileVarianceFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
