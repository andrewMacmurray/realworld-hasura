module Api.Object.ProfileStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileStddevSampFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileStddevSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
