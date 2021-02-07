module Api.Object.ArticlesStddevSampFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesStddevSampFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesStddevSampFields (Maybe Number)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesStddevSampFields (Maybe Number)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
