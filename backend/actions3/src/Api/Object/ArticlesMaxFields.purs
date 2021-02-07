module Api.Object.ArticlesMaxFields where

import GraphQLClient
  (SelectionSet, selectionForField, graphqlDefaultResponseScalarDecoder)
import Api.Scopes (Scope__ArticlesMaxFields)
import Data.Maybe (Maybe)
import Api.Scalars (Timestamptz)

about :: SelectionSet Scope__ArticlesMaxFields (Maybe String)
about = selectionForField "about" [] graphqlDefaultResponseScalarDecoder

author_id :: SelectionSet Scope__ArticlesMaxFields (Maybe Int)
author_id = selectionForField "author_id" [] graphqlDefaultResponseScalarDecoder

content :: SelectionSet Scope__ArticlesMaxFields (Maybe String)
content = selectionForField "content" [] graphqlDefaultResponseScalarDecoder

created_at :: SelectionSet Scope__ArticlesMaxFields (Maybe Timestamptz)
created_at = selectionForField
             "created_at"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__ArticlesMaxFields (Maybe Int)
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

title :: SelectionSet Scope__ArticlesMaxFields (Maybe String)
title = selectionForField "title" [] graphqlDefaultResponseScalarDecoder
