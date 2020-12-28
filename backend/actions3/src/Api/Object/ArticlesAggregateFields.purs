module Api.Object.ArticlesAggregateFields where

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
  ( Scope__ArticlesAvgFields
  , Scope__ArticlesAggregateFields
  , Scope__ArticlesMaxFields
  , Scope__ArticlesMinFields
  , Scope__ArticlesStddevFields
  , Scope__ArticlesStddevPopFields
  , Scope__ArticlesStddevSampFields
  , Scope__ArticlesSumFields
  , Scope__ArticlesVarPopFields
  , Scope__ArticlesVarSampFields
  , Scope__ArticlesVarianceFields
  )
import Data.Maybe (Maybe)
import Api.Enum.ArticlesSelectColumn (ArticlesSelectColumn)
import Type.Row (type (+))

avg :: forall r . SelectionSet
                  Scope__ArticlesAvgFields
                  r -> SelectionSet
                       Scope__ArticlesAggregateFields
                       (Maybe
                        r)
avg = selectionForCompositeField
      "avg"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CountInputRowOptional r = ( columns :: Optional
                                            (Array
                                             ArticlesSelectColumn)
                               , distinct :: Optional Boolean
                               | r
                               )

type CountInput = { | CountInputRowOptional + () }

count :: CountInput -> SelectionSet Scope__ArticlesAggregateFields (Maybe Int)
count input = selectionForField
              "count"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseScalarDecoder

max :: forall r . SelectionSet
                  Scope__ArticlesMaxFields
                  r -> SelectionSet
                       Scope__ArticlesAggregateFields
                       (Maybe
                        r)
max = selectionForCompositeField
      "max"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

min :: forall r . SelectionSet
                  Scope__ArticlesMinFields
                  r -> SelectionSet
                       Scope__ArticlesAggregateFields
                       (Maybe
                        r)
min = selectionForCompositeField
      "min"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev :: forall r . SelectionSet
                     Scope__ArticlesStddevFields
                     r -> SelectionSet
                          Scope__ArticlesAggregateFields
                          (Maybe
                           r)
stddev = selectionForCompositeField
         "stddev"
         []
         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_pop :: forall r . SelectionSet
                         Scope__ArticlesStddevPopFields
                         r -> SelectionSet
                              Scope__ArticlesAggregateFields
                              (Maybe
                               r)
stddev_pop = selectionForCompositeField
             "stddev_pop"
             []
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

stddev_samp :: forall r . SelectionSet
                          Scope__ArticlesStddevSampFields
                          r -> SelectionSet
                               Scope__ArticlesAggregateFields
                               (Maybe
                                r)
stddev_samp = selectionForCompositeField
              "stddev_samp"
              []
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

sum :: forall r . SelectionSet
                  Scope__ArticlesSumFields
                  r -> SelectionSet
                       Scope__ArticlesAggregateFields
                       (Maybe
                        r)
sum = selectionForCompositeField
      "sum"
      []
      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_pop :: forall r . SelectionSet
                      Scope__ArticlesVarPopFields
                      r -> SelectionSet
                           Scope__ArticlesAggregateFields
                           (Maybe
                            r)
var_pop = selectionForCompositeField
          "var_pop"
          []
          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

var_samp :: forall r . SelectionSet
                       Scope__ArticlesVarSampFields
                       r -> SelectionSet
                            Scope__ArticlesAggregateFields
                            (Maybe
                             r)
var_samp = selectionForCompositeField
           "var_samp"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

variance :: forall r . SelectionSet
                       Scope__ArticlesVarianceFields
                       r -> SelectionSet
                            Scope__ArticlesAggregateFields
                            (Maybe
                             r)
variance = selectionForCompositeField
           "variance"
           []
           graphqlDefaultResponseFunctorOrScalarDecoderTransformer
