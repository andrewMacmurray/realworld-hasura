module Api.Object.TagsMutationResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__TagsMutationResponse, Scope__Tags)

affected_rows :: SelectionSet Scope__TagsMutationResponse Int
affected_rows = selectionForField
                "affected_rows"
                []
                graphqlDefaultResponseScalarDecoder

returning :: forall r . SelectionSet
                        Scope__Tags
                        r -> SelectionSet
                             Scope__TagsMutationResponse
                             (Array
                              r)
returning = selectionForCompositeField
            "returning"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer
