module Api.Object.ProfileAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__ProfileAggregateFields, Scope__ProfileAggregate, Scope__Profile)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__ProfileAggregateFields
                        r -> SelectionSet
                             Scope__ProfileAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Profile
                    r -> SelectionSet
                         Scope__ProfileAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
