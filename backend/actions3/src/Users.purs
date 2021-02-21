module Users
  ( find
  , create
  , User
  , Id
  ) where

import Prelude
import Control.Monad.Except (except, withExceptT)
import Crypto.Bcrypt (Hash)
import Data.Array as Array
import Data.Either (Either)
import Data.Either as Either
import Data.Maybe (Maybe)
import Hasura as Hasura

type ToCreate
  = { username :: String
    , email :: String
    , password_hash :: Hash
    }

type User
  = { id :: Id
    , username :: String
    , email :: String
    , password_hash :: Hash
    , bio :: Maybe String
    , profile_image :: Maybe String
    }

type Id
  = Int

-- Find
find :: String -> Hasura.Response User
find username = do
  response <- Hasura.request { query: getUserQuery, variables: { username } }
  except (toSelection response)

handleNotFound :: Maybe User -> Either Hasura.Error User
handleNotFound = Either.note "Invalid username / password combination"

toSelection :: { users :: Array User } -> Either Hasura.Error User
toSelection = _.users >>> Array.head >>> handleNotFound

getUserQuery :: String
getUserQuery =
  """
  query FindUser($username: String!) {
    users(where: { username: { _eq: $username } }) {
      id
      profile_image
      username
      email
      bio
      password_hash
    }
  }
"""

-- Create
create :: ToCreate -> Hasura.Response User
create toCreate = do
  toCreateSelection <$> withExceptT handleExistingUser (Hasura.request { query: createUserMutation, variables: toCreate })

toCreateSelection :: { create_user :: User } -> User
toCreateSelection = _.create_user

handleExistingUser :: Hasura.Error -> Hasura.Error
handleExistingUser err =
  if Hasura.isUniquenessError err then
    "User already exists"
  else
    "Unknown error " <> err

createUserMutation :: String
createUserMutation =
  """
  mutation CreateUser($email: String, $password_hash: String, $username: String) {
    create_user(object: {password_hash: $password_hash, username: $username, email: $email}) {
      id
      email
      bio
      password_hash
      profile_image
      username
    }
  }
"""
