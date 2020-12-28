module Api.Object.LikesMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesMaxFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesMaxFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesMaxFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
