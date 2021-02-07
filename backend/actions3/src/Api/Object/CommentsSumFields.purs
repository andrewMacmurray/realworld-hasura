module Api.Object.CommentsSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__CommentsSumFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__CommentsSumFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__CommentsSumFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__CommentsSumFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
