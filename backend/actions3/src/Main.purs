module Main where

import Prelude
import Api.Mutation (LoginInput, SignupInput)
import Crypto.Bcrypt as Bcyrypt
import Crypto.Jwt (Jwt)
import Data.Either (Either(..))
import Data.Nullable (Nullable, null)
import Effect (Effect)
import Effect.Aff (Aff)
import Payload.Headers as Headers
import Payload.ResponseTypes (Response(..))
import Payload.Server as Payload
import Payload.Spec (Routes, Spec(Spec), POST)
import Token as Token
import Users as Users

type ActionRequest a
  = { input :: a
    }

type TokenResponse
  = { token :: Jwt
    , user_id :: Int
    , username :: String
    , email :: String
    , bio :: Nullable String
    , profile_image :: Nullable String
    }

type Api
  = Spec { api :: Routes "/api" Api_ }

type Api_
  = { login ::
        POST "/login"
          { body :: ActionRequest LoginInput
          , response :: TokenResponse
          }
    , signup ::
        POST "/signup"
          { body :: ActionRequest SignupInput
          , response :: TokenResponse
          }
    }

spec :: Api
spec = Spec

login :: { body :: ActionRequest LoginInput } -> Aff TokenResponse
login { body: { input } } =
  pure
    { token: Token.generate { id: 1, username: input.username }
    , user_id: 1
    , username: input.username
    , email: "a@b.com"
    , bio: null
    , profile_image: null
    }

signup :: { body :: ActionRequest SignupInput } -> Aff (Either ActionError TokenResponse)
signup { body: { input } } = do
  user <-
    Users.create
      { username: input.username
      , email: input.email
      , password_hash: Bcyrypt.hash input.password
      }
  case user of
    Right u ->
      pure
        ( Right
            { token: Token.generate u
            , user_id: u.id
            , username: u.username
            , email: u.email
            , bio: null
            , profile_image: null
            }
        )
    Left err -> pure (actionError 400 "user create error")

main :: Effect Unit
main =
  Payload.launch spec
    { api:
        { login
        , signup
        }
    }

actionError :: forall a. Int -> String -> Either ActionError a
actionError code reason =
  Left
    ( Response
        { body: { message: reason, code: show code }
        , headers: Headers.empty
        , status: { code, reason }
        }
    )

type ActionError
  = Response
      { message :: String
      , code :: String
      }
