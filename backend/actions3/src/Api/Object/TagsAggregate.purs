module Api.Object.TagsAggregate where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  )
import Api.Scopes
  (Scope__TagsAggregateFields, Scope__TagsAggregate, Scope__Tags)
import Data.Maybe (Maybe)

aggregate :: forall r . SelectionSet
                        Scope__TagsAggregateFields
                        r -> SelectionSet
                             Scope__TagsAggregate
                             (Maybe
                              r)
aggregate = selectionForCompositeField
            "aggregate"
            []
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

nodes :: forall r . SelectionSet
                    Scope__Tags
                    r -> SelectionSet
                         Scope__TagsAggregate
                         (Array
                          r)
nodes = selectionForCompositeField
        "nodes"
        []
        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
