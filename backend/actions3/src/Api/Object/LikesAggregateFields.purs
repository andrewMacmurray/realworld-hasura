module Api.Object.LikesAggregateFields where

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
  ( Scope__LikesAvgFields
  , Scope__LikesAggregateFields
  , Scope__LikesMaxFields
  , Scope__LikesMinFields
  , Scope__LikesStddevFields
  , Scope__LikesStddevPopFields
  , Scope__LikesStddevSampFields
  , Scope__LikesSumFields
  , Scope__LikesVarPopFields
  , Scope__LikesVarSampFields
  , Scope__LikesVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.LikesSelectColumn (LikesSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__LikesAvgFields
                  r -> SelectionSet
                       Scope__LikesAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional (Array LikesSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__LikesAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__LikesMaxFields
                  r -> SelectionSet
                       Scope__LikesAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__LikesMinFields
                  r -> SelectionSet
                       Scope__LikesAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__LikesStddevFields
                     r -> SelectionSet
                          Scope__LikesAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__LikesStddevPopFields
                         r -> SelectionSet
                              Scope__LikesAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__LikesStddevSampFields
                          r -> SelectionSet
                               Scope__LikesAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__LikesSumFields
                  r -> SelectionSet
                       Scope__LikesAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__LikesVarPopFields
                      r -> SelectionSet
                           Scope__LikesAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__LikesVarSampFields
                       r -> SelectionSet
                            Scope__LikesAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__LikesVarianceFields
                       r -> SelectionSet
                            Scope__LikesAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
