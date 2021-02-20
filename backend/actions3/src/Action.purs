module Action
  ( error
  , userId
  , Request
  , UserRequest
  , Response
  , Error
  , UserId
  ) where

import Prelude
import Control.Monad.Except (except)
import Data.Either (Either)
import Data.Either as Either
import Data.Int as Int
import Data.List.Types (NonEmptyList)
import Data.Newtype (class Newtype, unwrap)
import Effect.Aff (Aff)
import Foreign (F, ForeignError(..))
import Payload.Headers as Headers
import Payload.ResponseTypes as Payload
import Simple.JSON (class ReadForeign, readImpl)

-- Request
type Request a
  = { input :: a }

type UserRequest a
  = { input :: a
    , session_variables :: { "x-hasura-user-id" :: UserId }
    }

newtype UserId
  = UserId Int

type Response a
  = Aff (Either Error a)

type Error
  = Payload.Response
      { message :: String
      , code :: String
      }

-- User Id
userId :: forall a. UserRequest a -> Int
userId request = unwrap $ request.session_variables."x-hasura-user-id"

derive instance newtypeUserId :: Newtype UserId _

instance readForeignUserId :: ReadForeign UserId where
  readImpl f = do
    id <- readImpl f :: F String
    except (UserId <$> readUserId_ id)

readUserId_ :: String -> Either (NonEmptyList ForeignError) Int
readUserId_ = Int.fromString >>> Either.note errorMessage
  where
  errorMessage = pure (ForeignError "invalid user id")

-- Error
error :: Int -> String -> Error
error code reason =
  Payload.Response
    { body: { message: reason, code: show code }
    , headers: Headers.empty
    , status: { code, reason }
    }
