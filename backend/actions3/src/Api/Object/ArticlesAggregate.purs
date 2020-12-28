module Api.Object.ArticlesAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__ArticlesAggregateFields, Scope__ArticlesAggregate, Scope__Articles)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__ArticlesAggregateFields
                        r -> SelectionSet
                             Scope__ArticlesAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Articles
                    r -> SelectionSet
                         Scope__ArticlesAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
