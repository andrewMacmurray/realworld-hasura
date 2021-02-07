module Api.Object.UsersAggregateFields where

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
  ( Scope__UsersAvgFields
  , Scope__UsersAggregateFields
  , Scope__UsersMaxFields
  , Scope__UsersMinFields
  , Scope__UsersStddevFields
  , Scope__UsersStddevPopFields
  , Scope__UsersStddevSampFields
  , Scope__UsersSumFields
  , Scope__UsersVarPopFields
  , Scope__UsersVarSampFields
  , Scope__UsersVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.UsersSelectColumn (UsersSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__UsersAvgFields
                  r -> SelectionSet
                       Scope__UsersAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional (Array UsersSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__UsersAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__UsersMaxFields
                  r -> SelectionSet
                       Scope__UsersAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__UsersMinFields
                  r -> SelectionSet
                       Scope__UsersAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__UsersStddevFields
                     r -> SelectionSet
                          Scope__UsersAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__UsersStddevPopFields
                         r -> SelectionSet
                              Scope__UsersAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__UsersStddevSampFields
                          r -> SelectionSet
                               Scope__UsersAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__UsersSumFields
                  r -> SelectionSet
                       Scope__UsersAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__UsersVarPopFields
                      r -> SelectionSet
                           Scope__UsersAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__UsersVarSampFields
                       r -> SelectionSet
                            Scope__UsersAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__UsersVarianceFields
                       r -> SelectionSet
                            Scope__UsersAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
