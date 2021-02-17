module Main where

import Prelude
import Action as Action
import Api.Mutation (LoginInput, SignupInput)
import Control.Monad.Except (ExceptT, except, runExceptT)
import Crypto.Jwt (Jwt)
import Data.Bifunctor (bimap)
import Data.Either (Either)
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect.Aff (Aff)
import Password as Password
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

-- Login
login :: { body :: Action.Request LoginInput } -> Action.Response TokenResponse
login request = toTokenResponse <$> runExceptT (handleLogin request.body.input)

handleLogin :: LoginInput -> ExceptT String Aff User
handleLogin input = do
  user <- Users.find input.username
  except (Password.check input.password user)

--  Signup
signup :: { body :: Action.Request SignupInput } -> Action.Response TokenResponse
signup request = toTokenResponse <$> runExceptT (handleSignup request.body.input)

handleSignup :: SignupInput -> ExceptT String Aff User
handleSignup input = do
  hash <- except (Password.hash input.password)
  Users.create
    { username: input.username
    , email: input.email
    , password_hash: hash
    }

-- Token Response
type TokenResponse
  = { token :: Jwt
    , user_id :: Int
    , username :: String
    , email :: String
    , bio :: Nullable String
    , profile_image :: Nullable String
    }

toTokenResponse :: Either String User -> Either Action.Error TokenResponse
toTokenResponse = bimap error tokenResponse

tokenResponse :: User -> TokenResponse
tokenResponse u =
  { token: Token.generate u
  , user_id: u.id
  , username: u.username
  , email: u.email
  , bio: toNullable u.bio
  , profile_image: toNullable u.profile_image
  }

error :: String -> Action.Error
error = Action.error 400
