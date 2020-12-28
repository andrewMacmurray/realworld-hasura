module Api.Object.ArticlesAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesAvgFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesAvgFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
