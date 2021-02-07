module Api.Enum.TagsConstraint where

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

-- | original name - tags_constraint
data TagsConstraint = TagsArticleIdTagKey | TagsPkey

derive instance genericTagsConstraint :: Generic TagsConstraint _

instance showTagsConstraint :: Show TagsConstraint where
  show = genericShow

derive instance eqTagsConstraint :: Eq TagsConstraint

derive instance ordTagsConstraint :: Ord TagsConstraint

fromToMap :: Array (Tuple String TagsConstraint)
fromToMap = [ Tuple "tags_article_id_tag_key" TagsArticleIdTagKey
            , Tuple "tags_pkey" TagsPkey
            ]

instance tagsConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                              TagsConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder "TagsConstraint" fromToMap

instance tagsConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                 TagsConstraint where
  toGraphQLArgumentValue =
    case _ of
      TagsArticleIdTagKey -> ArgumentValueEnum "tags_article_id_tag_key"
      TagsPkey -> ArgumentValueEnum "tags_pkey"
