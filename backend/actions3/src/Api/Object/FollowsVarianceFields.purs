module Api.Object.FollowsVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__FollowsVarianceFields)
import Data.Maybe (Maybe)

following_id :: SelectionSet Scope__FollowsVarianceFields (Maybe Number)
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__FollowsVarianceFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__FollowsVarianceFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
