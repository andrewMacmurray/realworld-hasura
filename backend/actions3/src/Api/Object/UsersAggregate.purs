module Api.Object.UsersAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__UsersAggregateFields, Scope__UsersAggregate, Scope__Users)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__UsersAggregateFields
                        r -> SelectionSet
                             Scope__UsersAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Users
                    r -> SelectionSet
                         Scope__UsersAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
