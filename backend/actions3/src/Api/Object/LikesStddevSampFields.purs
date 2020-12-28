module Api.Object.LikesStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesStddevSampFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesStddevSampFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesStddevSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
