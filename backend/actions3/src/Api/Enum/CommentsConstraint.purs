module Api.Enum.CommentsConstraint where

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

-- | original name - comments_constraint
data CommentsConstraint = CommentsPkey

derive instance genericCommentsConstraint :: Generic CommentsConstraint _

instance showCommentsConstraint :: Show CommentsConstraint where
  show = genericShow

derive instance eqCommentsConstraint :: Eq CommentsConstraint

derive instance ordCommentsConstraint :: Ord CommentsConstraint

fromToMap :: Array (Tuple String CommentsConstraint)
fromToMap = [ Tuple "comments_pkey" CommentsPkey ]

instance commentsConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                  CommentsConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "CommentsConstraint"
                                        fromToMap

instance commentsConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                     CommentsConstraint where
  toGraphQLArgumentValue =
    case _ of
      CommentsPkey -> ArgumentValueEnum "comments_pkey"
