module Api.Object.ArticlesVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesVarPopFields)
import Data.Maybe (Maybe)

id :: SelectionSet Scope__ArticlesVarPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
