module Api.Object.CommentsAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__CommentsAggregateFields, Scope__CommentsAggregate, Scope__Comments)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__CommentsAggregateFields
                        r -> SelectionSet
                             Scope__CommentsAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Comments
                    r -> SelectionSet
                         Scope__CommentsAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
