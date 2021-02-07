module Api.Object.ProfileSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ProfileSumFields)
import Data.Maybe (Maybe)

user_id :: SelectionSet Scope__ProfileSumFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
