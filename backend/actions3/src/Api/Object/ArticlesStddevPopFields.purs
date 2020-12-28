module Api.Object.ArticlesStddevPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevPopFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesStddevPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
