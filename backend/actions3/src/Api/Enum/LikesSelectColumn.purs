module Api.Enum.LikesSelectColumn where

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

-- | original name - likes_select_column
data LikesSelectColumn = ArticleId | Id | UserId

derive instance genericLikesSelectColumn :: Generic LikesSelectColumn _

instance showLikesSelectColumn :: Show LikesSelectColumn where
  show = genericShow

derive instance eqLikesSelectColumn :: Eq LikesSelectColumn

derive instance ordLikesSelectColumn :: Ord LikesSelectColumn

fromToMap :: Array (Tuple String LikesSelectColumn)
fromToMap = [ Tuple "article_id" ArticleId
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance likesSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                 LikesSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "LikesSelectColumn"
                                        fromToMap

instance likesSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                    LikesSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      ArticleId -> ArgumentValueEnum "article_id"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
