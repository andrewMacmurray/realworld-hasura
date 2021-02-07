module Api.Object.ArticlesVarSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesVarSampFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesVarSampFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesVarSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
