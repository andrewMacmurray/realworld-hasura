module Api.Enum.OrderBy where

import Data.Generic.Rep (class Generic)
import Data.Show (class Show)
import Data.Generic.Rep.Show (genericShow)
import Prelude (class Eq, class Ord)
import Data.Tuple (Tuple(..))
import GraphQLClient
  ( class GraphQLDefaultResponseScalarDecoder
  , enumDecoder
  , class ToGraphQLArgumentValue
  , ArgumentValue(..)
  )

-- | original name - order_by
data OrderBy
  = Asc | AscNullsFirst | AscNullsLast | Desc | DescNullsFirst | DescNullsLast

derive instance genericOrderBy :: Generic OrderBy _

instance showOrderBy :: Show OrderBy where
  show = genericShow

derive instance eqOrderBy :: Eq OrderBy

derive instance ordOrderBy :: Ord OrderBy

fromToMap :: Array (Tuple String OrderBy)
fromToMap = [ Tuple "asc" Asc
            , Tuple "asc_nulls_first" AscNullsFirst
            , Tuple "asc_nulls_last" AscNullsLast
            , Tuple "desc" Desc
            , Tuple "desc_nulls_first" DescNullsFirst
            , Tuple "desc_nulls_last" DescNullsLast
            ]

instance orderByGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                       OrderBy where
  graphqlDefaultResponseScalarDecoder = enumDecoder "OrderBy" fromToMap

instance orderByToGraphQLArgumentValue :: ToGraphQLArgumentValue OrderBy where
  toGraphQLArgumentValue =
    case _ of
      Asc -> ArgumentValueEnum "asc"
      AscNullsFirst -> ArgumentValueEnum "asc_nulls_first"
      AscNullsLast -> ArgumentValueEnum "asc_nulls_last"
      Desc -> ArgumentValueEnum "desc"
      DescNullsFirst -> ArgumentValueEnum "desc_nulls_first"
      DescNullsLast -> ArgumentValueEnum "desc_nulls_last"
