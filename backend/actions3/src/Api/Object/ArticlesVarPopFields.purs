module Api.Object.ArticlesVarPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesVarPopFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesVarPopFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesVarPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
