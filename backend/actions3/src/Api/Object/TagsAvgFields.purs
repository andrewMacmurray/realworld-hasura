module Api.Object.TagsAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsAvgFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsAvgFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsAvgFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
