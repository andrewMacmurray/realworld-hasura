module Api.Object.ArticlesVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesVarSampFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesVarSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
