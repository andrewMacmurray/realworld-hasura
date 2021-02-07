module Api.Object.TagsMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsMaxFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsMaxFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsMaxFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

tag :: SelectionSet Scope__TagsMaxFields (Maybe String)
tag = selectionForField "tag" [] graphqlDefaultResponseScalarDecoder
