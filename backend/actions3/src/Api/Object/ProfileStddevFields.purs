module Api.Object.ProfileStddevFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileStddevFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileStddevFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
