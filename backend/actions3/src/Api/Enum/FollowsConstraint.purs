module Api.Enum.FollowsConstraint where

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

-- | original name - follows_constraint
data FollowsConstraint = FollowsPkey | FollowsUserIdFollowingKey

derive instance genericFollowsConstraint :: Generic FollowsConstraint _

instance showFollowsConstraint :: Show FollowsConstraint where
  show = genericShow

derive instance eqFollowsConstraint :: Eq FollowsConstraint

derive instance ordFollowsConstraint :: Ord FollowsConstraint

fromToMap :: Array (Tuple String FollowsConstraint)
fromToMap = [ Tuple "follows_pkey" FollowsPkey
            , Tuple "follows_user_id_following_key" FollowsUserIdFollowingKey
            ]

instance followsConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                 FollowsConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "FollowsConstraint"
                                        fromToMap

instance followsConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                    FollowsConstraint where
  toGraphQLArgumentValue =
    case _ of
      FollowsPkey -> ArgumentValueEnum "follows_pkey"
      FollowsUserIdFollowingKey -> ArgumentValueEnum
                                   "follows_user_id_following_key"
