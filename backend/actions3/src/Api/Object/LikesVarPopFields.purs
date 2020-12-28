module Api.Object.LikesVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__LikesVarPopFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__LikesVarPopFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

user_id :: SelectionSet Scope__LikesVarPopFields (Maybe Number)
user_id = selectionForField "user_id" [] graphqlDefaultResponseScalarDecoder
