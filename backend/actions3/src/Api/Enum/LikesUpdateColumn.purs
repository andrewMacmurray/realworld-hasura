module Api.Enum.LikesUpdateColumn where

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

-- | original name - likes_update_column
data LikesUpdateColumn = ArticleId | Id | UserId

derive instance genericLikesUpdateColumn :: Generic LikesUpdateColumn _

instance showLikesUpdateColumn :: Show LikesUpdateColumn where
  show = genericShow

derive instance eqLikesUpdateColumn :: Eq LikesUpdateColumn

derive instance ordLikesUpdateColumn :: Ord LikesUpdateColumn

fromToMap :: Array (Tuple String LikesUpdateColumn)
fromToMap = [ Tuple "article_id" ArticleId
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance likesUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                 LikesUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "LikesUpdateColumn"
                                        fromToMap

instance likesUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                    LikesUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      ArticleId -> ArgumentValueEnum "article_id"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
