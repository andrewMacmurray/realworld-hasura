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
data CommentsUpdateColumn = Comment

derive instance genericCommentsUpdateColumn :: Generic CommentsUpdateColumn _

instance showCommentsUpdateColumn :: Show CommentsUpdateColumn where
  show = genericShow

derive instance eqCommentsUpdateColumn :: Eq CommentsUpdateColumn

derive instance ordCommentsUpdateColumn :: Ord CommentsUpdateColumn

fromToMap :: Array (Tuple String CommentsUpdateColumn)
fromToMap = [ Tuple "comment" Comment ]

instance commentsUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                    CommentsUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "CommentsUpdateColumn"
                                        fromToMap

instance commentsUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                       CommentsUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      Comment -> ArgumentValueEnum "comment"
