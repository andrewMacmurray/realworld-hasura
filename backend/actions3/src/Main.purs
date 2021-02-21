module Main where

import Prelude
import Action as Action
import Articles (ArticleId)
import Articles as Articles
import Control.Monad.Except (ExceptT, except, runExceptT)
import Crypto.Jwt (Jwt)
import Data.Bifunctor (bimap)
import Data.Either (Either(..))
import Data.Maybe (Maybe, maybe)
import Data.Nullable (Nullable, toNullable)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff as Aff
import Env as Env
import Node.HTTP as HTTP
import Password as Password
import Payload.Headers as Headers
import Payload.Server as Payload
import Payload.Server.Guards (headers)
import Payload.Spec (type (:), Guards, Nil, POST, Routes, Spec(Spec))
import Token as Token
import Users (User)
import Users as Users

-- Api
type Api
  = Spec
      { routes :: ApiRoutes_
      , guards :: Guards_
      }

type ApiRoutes_
  = { api :: Routes "/api" Api_
    , guards :: Guards ("secured" : Nil)
    }

type Guards_
  = { secured :: Unit
    }

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
    , unlike ::
        POST "/unlike"
          { body :: Action.UserRequest UnlikeArticleInput
          , response :: UnlikeResponse
          }
    }

spec :: Api
spec = Spec

main :: Effect Unit
main =
  Aff.launchAff_
    ( Payload.startGuarded_ spec
        { guards:
            { secured
            }
        , handlers:
            { api:
                { login
                , signup
                , unlike
                }
            }
        }
    )

-- Login
login :: forall r. { body :: Action.Request LoginInput | r } -> Action.Response TokenResponse
login request = toTokenResponse <$> runExceptT (handleLogin request.body.input)

handleLogin :: LoginInput -> ExceptT String Aff User
handleLogin input = do
  user <- Users.find input.username
  except (Password.check input.password user)

--  Signup
signup :: forall r. { body :: Action.Request SignupInput | r } -> Action.Response TokenResponse
signup request = toTokenResponse <$> runExceptT (handleSignup request.body.input)

handleSignup :: SignupInput -> ExceptT String Aff User
handleSignup input = do
  hash <- except (Password.hash input.password)
  Users.create
    { username: input.username
    , email: input.email
    , password_hash: hash
    }

-- Unlike
type UnlikeArticleInput
  = { article_id :: Int }

type UnlikeResponse
  = { article_id :: Int }

unlike :: forall r. { body :: Action.UserRequest UnlikeArticleInput | r } -> Action.Response UnlikeResponse
unlike request = toUnlikeResponse <$> runExceptT (handleUnlike request.body)

handleUnlike :: Action.UserRequest UnlikeArticleInput -> ExceptT String Aff ArticleId
handleUnlike body = do
  Articles.unlike
    { article_id: body.input.article_id
    , user_id: Action.userId body
    }

toUnlikeResponse :: Either String ArticleId -> Either Action.Error UnlikeResponse
toUnlikeResponse = bimap error { article_id: _ }

-- Auth Request Response
type LoginInput
  = { username :: String
    , password :: String
    }

type SignupInput
  = { username :: String
    , email :: String
    , password :: String
    }

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

-- Guards
secured :: HTTP.Request -> Aff (Either String Unit)
secured req = checkSecret <$> Headers.lookup "actions-secret" <$> headers req

checkSecret :: Maybe String -> Either String Unit
checkSecret = maybe (Left "missing secret") checkSecret_

checkSecret_ :: String -> Either String Unit
checkSecret_ secret =
  if secret == Env.actionsSecret then
    Right unit
  else
    Left "invalid secret"
