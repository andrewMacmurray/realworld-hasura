module Api.Object.FollowsAggregateFields where

import GraphQLClient
  ( SelectionSet
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , Optional
  , selectionForField
  , toGraphQLArguments
  , graphqlDefaultResponseScalarDecoder
  )
import Api.Scopes
  ( Scope__FollowsAvgFields
  , Scope__FollowsAggregateFields
  , Scope__FollowsMaxFields
  , Scope__FollowsMinFields
  , Scope__FollowsStddevFields
  , Scope__FollowsStddevPopFields
  , Scope__FollowsStddevSampFields
  , Scope__FollowsSumFields
  , Scope__FollowsVarPopFields
  , Scope__FollowsVarSampFields
  , Scope__FollowsVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.FollowsSelectColumn (FollowsSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__FollowsAvgFields
                  r -> SelectionSet
                       Scope__FollowsAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional (Array FollowsSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__FollowsAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__FollowsMaxFields
                  r -> SelectionSet
                       Scope__FollowsAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__FollowsMinFields
                  r -> SelectionSet
                       Scope__FollowsAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__FollowsStddevFields
                     r -> SelectionSet
                          Scope__FollowsAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__FollowsStddevPopFields
                         r -> SelectionSet
                              Scope__FollowsAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__FollowsStddevSampFields
                          r -> SelectionSet
                               Scope__FollowsAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__FollowsSumFields
                  r -> SelectionSet
                       Scope__FollowsAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__FollowsVarPopFields
                      r -> SelectionSet
                           Scope__FollowsAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__FollowsVarSampFields
                       r -> SelectionSet
                            Scope__FollowsAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__FollowsVarianceFields
                       r -> SelectionSet
                            Scope__FollowsAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
