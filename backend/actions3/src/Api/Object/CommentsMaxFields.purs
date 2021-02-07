module Api.Object.CommentsMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__CommentsMaxFields)
import Data.Maybe (Maybe)
import Api.Scalars (Timestamptz)

article_id :: SelectionSet Scope__CommentsMaxFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

comment :: SelectionSet Scope__CommentsMaxFields (Maybe String)
comment = selectionForField "comment" [] graphqlDefaultResponseScalarDecoder

created_at :: SelectionSet Scope__CommentsMaxFields (Maybe Timestamptz)
created_at = selectionForField
             "created_at"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__CommentsMaxFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__CommentsMaxFields (Maybe Int)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
