module Api.Object.TagsAggregateFields where

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
  ( Scope__TagsAvgFields
  , Scope__TagsAggregateFields
  , Scope__TagsMaxFields
  , Scope__TagsMinFields
  , Scope__TagsStddevFields
  , Scope__TagsStddevPopFields
  , Scope__TagsStddevSampFields
  , Scope__TagsSumFields
  , Scope__TagsVarPopFields
  , Scope__TagsVarSampFields
  , Scope__TagsVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.TagsSelectColumn (TagsSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__TagsAvgFields
                  r -> SelectionSet
                       Scope__TagsAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional (Array TagsSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__TagsAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__TagsMaxFields
                  r -> SelectionSet
                       Scope__TagsAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__TagsMinFields
                  r -> SelectionSet
                       Scope__TagsAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__TagsStddevFields
                     r -> SelectionSet
                          Scope__TagsAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__TagsStddevPopFields
                         r -> SelectionSet
                              Scope__TagsAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__TagsStddevSampFields
                          r -> SelectionSet
                               Scope__TagsAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__TagsSumFields
                  r -> SelectionSet
                       Scope__TagsAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__TagsVarPopFields
                      r -> SelectionSet
                           Scope__TagsAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__TagsVarSampFields
                       r -> SelectionSet
                            Scope__TagsAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__TagsVarianceFields
                       r -> SelectionSet
                            Scope__TagsAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
