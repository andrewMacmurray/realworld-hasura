module Api.Object.LikesVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesVarSampFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesVarSampFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesVarSampFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
