module Api.Enum.TagsSelectColumn where

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

-- | original name - tags_select_column
data TagsSelectColumn = Tag

derive instance genericTagsSelectColumn :: Generic TagsSelectColumn _

instance showTagsSelectColumn :: Show TagsSelectColumn where
  show = genericShow

derive instance eqTagsSelectColumn :: Eq TagsSelectColumn

derive instance ordTagsSelectColumn :: Ord TagsSelectColumn

fromToMap :: Array (Tuple String TagsSelectColumn)
fromToMap = [ Tuple "tag" Tag ]

instance tagsSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                TagsSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder "TagsSelectColumn" fromToMap

instance tagsSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                   TagsSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      Tag -> ArgumentValueEnum "tag"
