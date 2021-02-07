module Api.Object.ArticlesStddevPopFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevPopFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesStddevPopFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesStddevPopFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
