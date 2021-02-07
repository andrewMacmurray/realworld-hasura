module Api.Object.ProfileVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileVarSampFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileVarSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
