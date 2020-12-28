module Api.Object.LikesAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesAvgFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesAvgFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesAvgFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
