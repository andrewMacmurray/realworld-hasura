module Api.Object.ProfileMutationResponse where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes (Scope__ProfileMutationResponse, Scope__Profile)

affected_rows :: SelectionSet Scope__ProfileMutationResponse Int
affected_rows = selectionForField
                "affected_rows"
                []
                graphqlDefaultResponseScalarDecoder

returning :: forall r . SelectionSet
                        Scope__Profile
                        r -> SelectionSet
                             Scope__ProfileMutationResponse
                             (Array
                              r)
returning = selectionForCompositeField
            "returning"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer
