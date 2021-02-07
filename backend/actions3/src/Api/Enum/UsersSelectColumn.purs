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
data UsersSelectColumn
  = Bio | Email | Id | PasswordHash | ProfileImage | Username

derive instance genericUsersSelectColumn :: Generic UsersSelectColumn _

instance showUsersSelectColumn :: Show UsersSelectColumn where
  show = genericShow

derive instance eqUsersSelectColumn :: Eq UsersSelectColumn

derive instance ordUsersSelectColumn :: Ord UsersSelectColumn

fromToMap :: Array (Tuple String UsersSelectColumn)
fromToMap = [ Tuple "bio" Bio
            , Tuple "email" Email
            , Tuple "id" Id
            , Tuple "password_hash" PasswordHash
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
      Bio -> ArgumentValueEnum "bio"
      Email -> ArgumentValueEnum "email"
      Id -> ArgumentValueEnum "id"
      PasswordHash -> ArgumentValueEnum "password_hash"
      ProfileImage -> ArgumentValueEnum "profile_image"
      Username -> ArgumentValueEnum "username"
