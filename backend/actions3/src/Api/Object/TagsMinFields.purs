module Api.Object.TagsMinFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__TagsMinFields)
import Data.Maybe (Maybe)

article_id :: SelectionSet Scope__TagsMinFields (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__TagsMinFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

tag :: SelectionSet Scope__TagsMinFields (Maybe String)
tag = selectionForField "tag" [] graphqlDefaultResponseScalarDecoder
