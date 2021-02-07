module Api.Object.ArticlesVarianceFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesVarianceFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesVarianceFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesVarianceFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
