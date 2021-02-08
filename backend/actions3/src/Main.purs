module Main where

import Prelude
import Action as Action
import Api.Mutation (LoginInput, SignupInput)
import Crypto.Bcrypt as Bcyrypt
import Crypto.Jwt (Jwt)
import Data.Bifunctor (bimap)
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Payload.Server as Payload
import Payload.Spec (Routes, Spec(Spec), POST)
import Token as Token
import Users (User)
import Users as Users

-- Api
type Api
  = Spec { api :: Routes "/api" Api_ }

type Api_
  = { login ::
        POST "/login"
          { body :: Action.Request LoginInput
          , response :: TokenResponse
          }
    , signup ::
        POST "/signup"
          { body :: Action.Request SignupInput
          , response :: TokenResponse
          }
    }

spec :: Api
spec = Spec

main :: Effect Unit
main =
  Payload.launch spec
    { api:
        { login
        , signup
        }
    }

-- Handlers
type TokenResponse
  = { token :: Jwt
    , user_id :: Int
    , username :: String
    , email :: String
    , bio :: Nullable String
    , profile_image :: Nullable String
    }

login :: { body :: Action.Request LoginInput } -> Action.Response TokenResponse
login { body: { input } } = do
  user <- Users.find input.username
  pure
    ( bimap
        (error "user not found")
        tokenResponse
        user
    )

signup :: { body :: Action.Request SignupInput } -> Action.Response TokenResponse
signup { body: { input } } = do
  user <-
    Users.create
      { username: input.username
      , email: input.email
      , password_hash: Bcyrypt.hash input.password
      }
  pure
    ( bimap
        (error "error creating user")
        tokenResponse
        user
    )

error :: forall a. String -> a -> Action.Error
error = const <<< Action.error 400

tokenResponse :: User -> TokenResponse
tokenResponse u =
  { token: Token.generate u
  , user_id: u.id
  , username: u.username
  , email: u.email
  , bio: toNullable u.bio
  , profile_image: toNullable u.profile_image
  }
