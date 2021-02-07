module Api.Object.FollowsVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__FollowsVarSampFields)
import Data.Maybe (Maybe)

following_id :: SelectionSet Scope__FollowsVarSampFields (Maybe Number)
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__FollowsVarSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__FollowsVarSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
