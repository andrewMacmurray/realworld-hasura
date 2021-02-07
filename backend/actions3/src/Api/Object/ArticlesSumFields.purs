module Api.Object.ArticlesSumFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesSumFields)
import Data.Maybe (Maybe)

author_id :: SelectionSet Scope__ArticlesSumFields (Maybe Int)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesSumFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder
