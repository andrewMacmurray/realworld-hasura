module Action
  ( error
  , Request
  , Response
  , Error
  ) where

import Prelude
import Data.Either (Either)
import Effect.Aff (Aff)
import Payload.Headers as Headers
import Payload.ResponseTypes as Payload

type Request a
  = { input :: a }

type Response a
  = Aff (Either Error a)

type Error
  = Payload.Response
      { message :: String
      , code :: String
      }

error :: Int -> String -> Error
error code reason =
  Payload.Response
    { body: { message: reason, code: show code }
    , headers: Headers.empty
    , status: { code, reason }
    }
