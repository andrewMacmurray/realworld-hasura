module Api.Object.TagsStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsStddevSampFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsStddevSampFields (Maybe Number)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsStddevSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
