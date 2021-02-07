module Api.Object.ProfileAggregateFields where

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
  ( Scope__ProfileAvgFields
  , Scope__ProfileAggregateFields
  , Scope__ProfileMaxFields
  , Scope__ProfileMinFields
  , Scope__ProfileStddevFields
  , Scope__ProfileStddevPopFields
  , Scope__ProfileStddevSampFields
  , Scope__ProfileSumFields
  , Scope__ProfileVarPopFields
  , Scope__ProfileVarSampFields
  , Scope__ProfileVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.ProfileSelectColumn (ProfileSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__ProfileAvgFields
                  r -> SelectionSet
                       Scope__ProfileAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional (Array ProfileSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__ProfileAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__ProfileMaxFields
                  r -> SelectionSet
                       Scope__ProfileAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__ProfileMinFields
                  r -> SelectionSet
                       Scope__ProfileAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__ProfileStddevFields
                     r -> SelectionSet
                          Scope__ProfileAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__ProfileStddevPopFields
                         r -> SelectionSet
                              Scope__ProfileAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__ProfileStddevSampFields
                          r -> SelectionSet
                               Scope__ProfileAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__ProfileSumFields
                  r -> SelectionSet
                       Scope__ProfileAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__ProfileVarPopFields
                      r -> SelectionSet
                           Scope__ProfileAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__ProfileVarSampFields
                       r -> SelectionSet
                            Scope__ProfileAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__ProfileVarianceFields
                       r -> SelectionSet
                            Scope__ProfileAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
