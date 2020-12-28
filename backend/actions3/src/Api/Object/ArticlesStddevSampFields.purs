module Api.Object.ArticlesStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevSampFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesStddevSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
