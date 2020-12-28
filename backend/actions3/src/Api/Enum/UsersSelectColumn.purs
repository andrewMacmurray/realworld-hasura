module Api.Enum.UsersSelectColumn where

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

-- | original name - users_select_column
data UsersSelectColumn = Id | ProfileImage | Username

derive instance genericUsersSelectColumn :: Generic UsersSelectColumn _

instance showUsersSelectColumn :: Show UsersSelectColumn where
  show = genericShow

derive instance eqUsersSelectColumn :: Eq UsersSelectColumn

derive instance ordUsersSelectColumn :: Ord UsersSelectColumn

fromToMap :: Array (Tuple String UsersSelectColumn)
fromToMap = [ Tuple "id" Id
            , Tuple "profile_image" ProfileImage
            , Tuple "username" Username
            ]

instance usersSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                 UsersSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "UsersSelectColumn"
                                        fromToMap

instance usersSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                    UsersSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      Id -> ArgumentValueEnum "id"
      ProfileImage -> ArgumentValueEnum "profile_image"
      Username -> ArgumentValueEnum "username"
