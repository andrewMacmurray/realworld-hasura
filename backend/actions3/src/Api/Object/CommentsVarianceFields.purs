module Api.Object.CommentsVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__CommentsVarianceFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__CommentsVarianceFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__CommentsVarianceFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__CommentsVarianceFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
