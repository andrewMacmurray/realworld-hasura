module Api.Object.LikesAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__LikesAggregateFields, Scope__LikesAggregate, Scope__Likes)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__LikesAggregateFields
                        r -> SelectionSet
                             Scope__LikesAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Likes
                    r -> SelectionSet
                         Scope__LikesAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
