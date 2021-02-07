module Users where

import Prelude
import Api.InputObject (UsersInsertInput(UsersInsertInput))
import Api.Mutation (CreateUserInput)
import Api.Mutation as Mutation
import Api.Object.Users as Users
import Crypto.Bcrypt (Hash)
import Data.Maybe (Maybe)
import Data.Newtype (unwrap)
import GraphQLClient (Optional(..), Scope__RootMutation, SelectionSet, defaultInput, nonNullOrFail)
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
    , bio :: Maybe String
    , profile_image :: Maybe String
    }

create :: ToCreate -> Hasura.Response User
create = Hasura.mutation <<< createUserMutation

createUserMutation :: ToCreate -> SelectionSet Scope__RootMutation User
createUserMutation toCreate =
  nonNullOrFail
    ( Mutation.create_user (toInputs toCreate)
        ( { id: _, username: _, email: _, bio: _, profile_image: _ }
            <$> Users.id
            <*> Users.username
            <*> Users.email
            <*> Users.bio
            <*> Users.profile_image
        )
    )

toInputs :: ToCreate -> CreateUserInput
toInputs toCreate =
  { object:
      UsersInsertInput
        { username: Present toCreate.username
        , email: Present toCreate.email
        , password_hash: Present (unwrap toCreate.password_hash)
        , id: Absent
        , bio: Absent
        , follows: Absent
        , profile_image: Absent
        , articles: Absent
        }
  , on_conflict: defaultInput
  }
