module Api.Object.ArticlesMinFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesMinFields)
import Data.Maybe (Maybe)
import Api.Scalars (Timestamptz)

about :: SelectionSet Scope__ArticlesMinFields (Maybe String)
about = selectionForField "about" [] graphqlDefaultResponseScalarDecoder

author_id :: SelectionSet Scope__ArticlesMinFields (Maybe Int)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

content :: SelectionSet Scope__ArticlesMinFields (Maybe String)
content = selectionForField "content" [] graphqlDefaultResponseScalarDecoder

created_at :: SelectionSet Scope__ArticlesMinFields (Maybe Timestamptz)
created_at = selectionForField
             "created_at"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesMinFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

title :: SelectionSet Scope__ArticlesMinFields (Maybe String)
title = selectionForField "title" [] graphqlDefaultResponseScalarDecoder
