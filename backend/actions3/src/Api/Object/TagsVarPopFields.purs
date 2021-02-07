module Api.Object.TagsVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsVarPopFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsVarPopFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsVarPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
