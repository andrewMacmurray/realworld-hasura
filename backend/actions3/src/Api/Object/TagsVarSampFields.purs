module Api.Object.TagsVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsVarSampFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsVarSampFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsVarSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
