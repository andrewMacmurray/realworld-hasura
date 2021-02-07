module Api.Enum.TagsUpdateColumn where

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

-- | original name - tags_update_column
data TagsUpdateColumn = ArticleId | Id | Tag

derive instance genericTagsUpdateColumn :: Generic TagsUpdateColumn _

instance showTagsUpdateColumn :: Show TagsUpdateColumn where
  show = genericShow

derive instance eqTagsUpdateColumn :: Eq TagsUpdateColumn

derive instance ordTagsUpdateColumn :: Ord TagsUpdateColumn

fromToMap :: Array (Tuple String TagsUpdateColumn)
fromToMap = [ Tuple "article_id" ArticleId, Tuple "id" Id, Tuple "tag" Tag ]

instance tagsUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                TagsUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder "TagsUpdateColumn" fromToMap

instance tagsUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                   TagsUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      ArticleId -> ArgumentValueEnum "article_id"
      Id -> ArgumentValueEnum "id"
      Tag -> ArgumentValueEnum "tag"
