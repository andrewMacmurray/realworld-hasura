module Api.Object.UnlikeResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Scopes (Scope__Articles, Scope__UnlikeResponse)
import Data.Maybe (Maybe)

article :: forall r . SelectionSet
                      Scope__Articles
                      r -> SelectionSet
                           Scope__UnlikeResponse
                           (Maybe
                            r)
article = selectionForCompositeField
          "article"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

article_id :: SelectionSet Scope__UnlikeResponse (Maybe Int)
article_id = selectionForField
             "article_id"
             []
             graphqlDefaultResponseScalarDecoder
