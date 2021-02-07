module Api.Enum.FollowsUpdateColumn where

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

-- | original name - follows_update_column
data FollowsUpdateColumn = FollowingId | Id | UserId

derive instance genericFollowsUpdateColumn :: Generic FollowsUpdateColumn _

instance showFollowsUpdateColumn :: Show FollowsUpdateColumn where
  show = genericShow

derive instance eqFollowsUpdateColumn :: Eq FollowsUpdateColumn

derive instance ordFollowsUpdateColumn :: Ord FollowsUpdateColumn

fromToMap :: Array (Tuple String FollowsUpdateColumn)
fromToMap = [ Tuple "following_id" FollowingId
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance followsUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                   FollowsUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "FollowsUpdateColumn"
                                        fromToMap

instance followsUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                      FollowsUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      FollowingId -> ArgumentValueEnum "following_id"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
