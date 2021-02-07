module Api.Object.ProfileVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileVarPopFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileVarPopFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
