module Api.Object.ArticlesStddevFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesStddevFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesStddevFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
