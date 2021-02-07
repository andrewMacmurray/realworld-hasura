module Api.Object.CommentsAggregateFields where

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
  ( Scope__CommentsAvgFields
  , Scope__CommentsAggregateFields
  , Scope__CommentsMaxFields
  , Scope__CommentsMinFields
  , Scope__CommentsStddevFields
  , Scope__CommentsStddevPopFields
  , Scope__CommentsStddevSampFields
  , Scope__CommentsSumFields
  , Scope__CommentsVarPopFields
  , Scope__CommentsVarSampFields
  , Scope__CommentsVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.CommentsSelectColumn (CommentsSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__CommentsAvgFields
                  r -> SelectionSet
                       Scope__CommentsAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional
                                            (Array
                                             CommentsSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__CommentsAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__CommentsMaxFields
                  r -> SelectionSet
                       Scope__CommentsAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__CommentsMinFields
                  r -> SelectionSet
                       Scope__CommentsAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__CommentsStddevFields
                     r -> SelectionSet
                          Scope__CommentsAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__CommentsStddevPopFields
                         r -> SelectionSet
                              Scope__CommentsAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__CommentsStddevSampFields
                          r -> SelectionSet
                               Scope__CommentsAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__CommentsSumFields
                  r -> SelectionSet
                       Scope__CommentsAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__CommentsVarPopFields
                      r -> SelectionSet
                           Scope__CommentsAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__CommentsVarSampFields
                       r -> SelectionSet
                            Scope__CommentsAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__CommentsVarianceFields
                       r -> SelectionSet
                            Scope__CommentsAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
