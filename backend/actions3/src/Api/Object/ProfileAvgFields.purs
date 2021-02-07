module Api.Object.ProfileAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileAvgFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileAvgFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
