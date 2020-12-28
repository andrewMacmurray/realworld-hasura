module Api.Object.CommentsMutationResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__CommentsMutationResponse, Scope__Comments)

affected_rows :: SelectionSet Scope__CommentsMutationResponse Int
affected_rows = selectionForField
                "affected_rows"
                []
                graphqlDefaultResponseScalarDecoder

returning :: forall r . SelectionSet
                        Scope__Comments
                        r -> SelectionSet
                             Scope__CommentsMutationResponse
                             (Array
                              r)
returning = selectionForCompositeField
            "returning"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer
