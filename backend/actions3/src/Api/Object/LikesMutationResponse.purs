module Api.Object.LikesMutationResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__LikesMutationResponse, Scope__Likes)

affected_rows :: SelectionSet Scope__LikesMutationResponse Int
affected_rows = selectionForField
                "affected_rows"
                []
                graphqlDefaultResponseScalarDecoder

returning :: forall r . SelectionSet
                        Scope__Likes
                        r -> SelectionSet
                             Scope__LikesMutationResponse
                             (Array
                              r)
returning = selectionForCompositeField
            "returning"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer
