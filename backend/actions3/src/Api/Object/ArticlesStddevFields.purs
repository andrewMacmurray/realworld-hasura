module Api.Object.ArticlesStddevFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesStddevFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
