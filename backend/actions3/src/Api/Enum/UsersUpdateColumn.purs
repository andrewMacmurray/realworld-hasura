module Api.Enum.UsersUpdateColumn where

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

-- | original name - users_update_column
data UsersUpdateColumn
  = Bio | Email | Id | PasswordHash | ProfileImage | Username

derive instance genericUsersUpdateColumn :: Generic UsersUpdateColumn _

instance showUsersUpdateColumn :: Show UsersUpdateColumn where
  show = genericShow

derive instance eqUsersUpdateColumn :: Eq UsersUpdateColumn

derive instance ordUsersUpdateColumn :: Ord UsersUpdateColumn

fromToMap :: Array (Tuple String UsersUpdateColumn)
fromToMap = [ Tuple "bio" Bio
            , Tuple "email" Email
            , Tuple "id" Id
            , Tuple "password_hash" PasswordHash
            , Tuple "profile_image" ProfileImage
            , Tuple "username" Username
            ]

instance usersUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                 UsersUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "UsersUpdateColumn"
                                        fromToMap

instance usersUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                    UsersUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      Bio -> ArgumentValueEnum "bio"
      Email -> ArgumentValueEnum "email"
      Id -> ArgumentValueEnum "id"
      PasswordHash -> ArgumentValueEnum "password_hash"
      ProfileImage -> ArgumentValueEnum "profile_image"
      Username -> ArgumentValueEnum "username"
