module Api.Enum.CommentsUpdateColumn where

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

-- | original name - comments_update_column
data CommentsUpdateColumn = ArticleId | Comment | CreatedAt | Id | UserId

derive instance genericCommentsUpdateColumn :: Generic CommentsUpdateColumn _

instance showCommentsUpdateColumn :: Show CommentsUpdateColumn where
  show = genericShow

derive instance eqCommentsUpdateColumn :: Eq CommentsUpdateColumn

derive instance ordCommentsUpdateColumn :: Ord CommentsUpdateColumn

fromToMap :: Array (Tuple String CommentsUpdateColumn)
fromToMap = [ Tuple "article_id" ArticleId
            , Tuple "comment" Comment
            , Tuple "created_at" CreatedAt
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance commentsUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                    CommentsUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "CommentsUpdateColumn"
                                        fromToMap

instance commentsUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                       CommentsUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      ArticleId -> ArgumentValueEnum "article_id"
      Comment -> ArgumentValueEnum "comment"
      CreatedAt -> ArgumentValueEnum "created_at"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
