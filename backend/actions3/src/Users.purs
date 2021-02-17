module Users
  ( find
  , create
  , User
  ) where

import Prelude
import Api.InputObject (StringComparisonExp(..), StringComparisonExp_, UsersBoolExp(..), UsersBoolExp_, UsersInsertInput(..), UsersInsertInput_)
import Api.Mutation (CreateUserInput)
import Api.Mutation as Mutation
import Api.Object.Users as Users
import Api.Query (UsersInput)
import Api.Query as Query
import Api.Scopes (Scope__Users)
import Control.Monad.Except (except)
import Crypto.Bcrypt (Hash)
import Data.Array as Array
import Data.Either (Either)
import Data.Either as Either
import Data.Maybe (Maybe)
import Data.Newtype (unwrap, wrap)
import GraphQLClient (Optional(..), Scope__RootMutation, Scope__RootQuery, SelectionSet, defaultInput, nonNullOrFail)
import Hasura as Hasura

type ToCreate
  = { username :: String
    , email :: String
    , password_hash :: Hash
    }

type User
  = { id :: Int
    , username :: String
    , email :: String
    , password_hash :: Hash
    , bio :: Maybe String
    , profile_image :: Maybe String
    }

-- Find
find :: String -> Hasura.Response User
find username = do
  user <- Hasura.query (findUserQuery username)
  except (handleNotFound user)

handleNotFound :: Maybe User -> Either String User
handleNotFound = Either.note "user not found"

findUserQuery :: String -> SelectionSet Scope__RootQuery (Maybe User)
findUserQuery username = Array.head <$> Query.users (toFindInput username) userSelection

toFindInput :: String -> UsersInput
toFindInput username =
  usersInput
    { "where" =
      Present
        ( UsersBoolExp
            usersBoolInput
              { username =
                Present
                  ( StringComparisonExp
                      compareStringInput { "_eq" = Present username }
                  )
              }
        )
    }

-- Create
create :: ToCreate -> Hasura.Response User
create = Hasura.mutation <<< createUserMutation

createUserMutation :: ToCreate -> SelectionSet Scope__RootMutation User
createUserMutation toCreate = nonNullOrFail (Mutation.create_user (toCreateInput toCreate) userSelection)

toCreateInput :: ToCreate -> CreateUserInput
toCreateInput toCreate =
  { object:
      UsersInsertInput
        ( userInsert
            { username = Present toCreate.username
            , email = Present toCreate.email
            , password_hash = Present (unwrap toCreate.password_hash)
            }
        )
  , on_conflict: defaultInput
  }

-- User Selection
userSelection :: SelectionSet Scope__Users User
userSelection =
  ( { id: _, username: _, email: _, password_hash: _, bio: _, profile_image: _ }
      <$> Users.id
      <*> Users.username
      <*> Users.email
      <*> (wrap <$> Users.password_hash)
      <*> Users.bio
      <*> Users.profile_image
  )

-- Defaults
userInsert :: UsersInsertInput_
userInsert = defaultInput

usersInput :: UsersInput
usersInput = defaultInput

usersBoolInput :: UsersBoolExp_
usersBoolInput = defaultInput

compareStringInput :: StringComparisonExp_
compareStringInput = defaultInput
