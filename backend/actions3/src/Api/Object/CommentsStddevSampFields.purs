module Api.Object.CommentsStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__CommentsStddevSampFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__CommentsStddevSampFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__CommentsStddevSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__CommentsStddevSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
