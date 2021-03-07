module Token (generate) where

import Prelude
import Crypto.Jwt (Jwt)
import Crypto.Jwt as Jwt

type User a
  = { id :: Int
    , username :: String
    | a
    }

generate :: forall a. User a -> Jwt
generate user =
  Jwt.sign
    { name: user.username
    , "https://hasura.io/jwt/claims":
        { "x-hasura-allowed-roles": [ "user" ]
        , "x-hasura-default-role": "user"
        , "x-hasura-user-id": show user.id
        }
    }
