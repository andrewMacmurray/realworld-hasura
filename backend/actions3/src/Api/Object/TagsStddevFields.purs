module Api.Object.TagsStddevFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsStddevFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsStddevFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsStddevFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
