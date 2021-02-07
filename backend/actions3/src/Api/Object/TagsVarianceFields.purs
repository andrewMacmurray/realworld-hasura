module Api.Object.TagsVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsVarianceFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsVarianceFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsVarianceFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
