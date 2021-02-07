module Api.Enum.CommentsSelectColumn where

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

-- | original name - comments_select_column
data CommentsSelectColumn = ArticleId | Comment | CreatedAt | Id | UserId

derive instance genericCommentsSelectColumn :: Generic CommentsSelectColumn _

instance showCommentsSelectColumn :: Show CommentsSelectColumn where
  show = genericShow

derive instance eqCommentsSelectColumn :: Eq CommentsSelectColumn

derive instance ordCommentsSelectColumn :: Ord CommentsSelectColumn

fromToMap :: Array (Tuple String CommentsSelectColumn)
fromToMap = [ Tuple "article_id" ArticleId
            , Tuple "comment" Comment
            , Tuple "created_at" CreatedAt
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance commentsSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                    CommentsSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "CommentsSelectColumn"
                                        fromToMap

instance commentsSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                       CommentsSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      ArticleId -> ArgumentValueEnum "article_id"
      Comment -> ArgumentValueEnum "comment"
      CreatedAt -> ArgumentValueEnum "created_at"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
