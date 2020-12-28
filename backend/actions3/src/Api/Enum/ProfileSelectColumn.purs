module Api.Enum.ProfileSelectColumn where

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

-- | original name - profile_select_column
data ProfileSelectColumn = Bio | Email | ProfileImage | UserId | Username

derive instance genericProfileSelectColumn :: Generic ProfileSelectColumn _

instance showProfileSelectColumn :: Show ProfileSelectColumn where
  show = genericShow

derive instance eqProfileSelectColumn :: Eq ProfileSelectColumn

derive instance ordProfileSelectColumn :: Ord ProfileSelectColumn

fromToMap :: Array (Tuple String ProfileSelectColumn)
fromToMap = [ Tuple "bio" Bio
            , Tuple "email" Email
            , Tuple "profile_image" ProfileImage
            , Tuple "user_id" UserId
            , Tuple "username" Username
            ]

instance profileSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                   ProfileSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "ProfileSelectColumn"
                                        fromToMap

instance profileSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                      ProfileSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      Bio -> ArgumentValueEnum "bio"
      Email -> ArgumentValueEnum "email"
      ProfileImage -> ArgumentValueEnum "profile_image"
      UserId -> ArgumentValueEnum "user_id"
      Username -> ArgumentValueEnum "username"
