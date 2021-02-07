module Api.Object.FollowsStddevPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__FollowsStddevPopFields)
import Data.Maybe (Maybe)

following_id :: SelectionSet Scope__FollowsStddevPopFields (Maybe Number)
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__FollowsStddevPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__FollowsStddevPopFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
