module Api.Object.FollowsAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__FollowsAggregateFields, Scope__FollowsAggregate, Scope__Follows)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__FollowsAggregateFields
                        r -> SelectionSet
                             Scope__FollowsAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Follows
                    r -> SelectionSet
                         Scope__FollowsAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
