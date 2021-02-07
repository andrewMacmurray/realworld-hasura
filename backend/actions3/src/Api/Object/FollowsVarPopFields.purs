module Api.Object.FollowsVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__FollowsVarPopFields)
import Data.Maybe (Maybe)

following_id :: SelectionSet Scope__FollowsVarPopFields (Maybe Number)
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__FollowsVarPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__FollowsVarPopFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
