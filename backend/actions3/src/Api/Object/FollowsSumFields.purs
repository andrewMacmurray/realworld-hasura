module Api.Object.FollowsSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__FollowsSumFields)
import Data.Maybe (Maybe)

following_id :: SelectionSet Scope__FollowsSumFields (Maybe Int)
following_id = selectionForField
               "following_id"
               []
               graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__FollowsSumFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__FollowsSumFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
