module Api.Object.ArticlesAvgFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesAvgFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesAvgFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesAvgFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
