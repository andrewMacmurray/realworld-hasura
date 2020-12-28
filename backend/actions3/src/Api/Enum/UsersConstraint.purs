module Api.Enum.UsersConstraint where

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

-- | original name - users_constraint
data UsersConstraint = UsersPkey | UsersUsernameKey

derive instance genericUsersConstraint :: Generic UsersConstraint _

instance showUsersConstraint :: Show UsersConstraint where
  show = genericShow

derive instance eqUsersConstraint :: Eq UsersConstraint

derive instance ordUsersConstraint :: Ord UsersConstraint

fromToMap :: Array (Tuple String UsersConstraint)
fromToMap = [ Tuple "users_pkey" UsersPkey
            , Tuple "users_username_key" UsersUsernameKey
            ]

instance usersConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                               UsersConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder "UsersConstraint" fromToMap

instance usersConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                  UsersConstraint where
  toGraphQLArgumentValue =
    case _ of
      UsersPkey -> ArgumentValueEnum "users_pkey"
      UsersUsernameKey -> ArgumentValueEnum "users_username_key"
