module Api.Object.TagsSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsSumFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsSumFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsSumFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
