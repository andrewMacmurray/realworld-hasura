module Api.Enum.FollowsSelectColumn where

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

-- | original name - follows_select_column
data FollowsSelectColumn = FollowingId | Id | UserId

derive instance genericFollowsSelectColumn :: Generic FollowsSelectColumn _

instance showFollowsSelectColumn :: Show FollowsSelectColumn where
  show = genericShow

derive instance eqFollowsSelectColumn :: Eq FollowsSelectColumn

derive instance ordFollowsSelectColumn :: Ord FollowsSelectColumn

fromToMap :: Array (Tuple String FollowsSelectColumn)
fromToMap = [ Tuple "following_id" FollowingId
            , Tuple "id" Id
            , Tuple "user_id" UserId
            ]

instance followsSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                   FollowsSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "FollowsSelectColumn"
                                        fromToMap

instance followsSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                      FollowsSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      FollowingId -> ArgumentValueEnum "following_id"
      Id -> ArgumentValueEnum "id"
      UserId -> ArgumentValueEnum "user_id"
