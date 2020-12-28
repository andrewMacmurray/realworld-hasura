module Api.Object.Tags where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Scopes (Scope__Articles, Scope__Tags)
import Data.Maybe (Maybe)

article :: forall r . SelectionSet
                      Scope__Articles
                      r -> SelectionSet
                           Scope__Tags
                           r
article = selectionForCompositeField
          "article"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

count :: SelectionSet Scope__Tags (Maybe Int)
count = selectionForField "count" [] graphqlDefaultResponseScalarDecoder

tag :: SelectionSet Scope__Tags String
tag = selectionForField "tag" [] graphqlDefaultResponseScalarDecoder
