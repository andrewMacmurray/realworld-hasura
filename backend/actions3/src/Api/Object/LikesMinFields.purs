module Api.Object.LikesMinFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesMinFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesMinFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__LikesMinFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesMinFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
