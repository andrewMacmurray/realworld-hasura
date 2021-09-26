module Hasura
  ( Request
  , Response
  , Error(..)
  , isUniquenessError
  , request
  ) where

import Prelude
import Affjax.RequestHeader (RequestHeader(..))
import Control.Alt ((<|>))
import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), contains)
import Data.String as String
import Effect.Aff (Aff)
import Effect.Aff.Class (liftAff)
import Effect.Class.Console as Console
import Env as Env
import Simple.Ajax (AjaxError)
import Simple.Ajax as Ajax
import Simple.JSON (class ReadForeign, class WriteForeign)
import Simple.JSON as JSON

type Request vars
  = { query :: String
    , variables :: vars
    }

type Response a
  = ExceptT Error Aff a

type Error
  = String

request :: forall a b. ReadForeign a => WriteForeign b => Request b -> Response a
request query = ExceptT (mapErrors <$> Ajax.postR { headers: [ adminSecret ] } Env.graphqlUrl (Just query))

isUniquenessError :: Error -> Boolean
isUniquenessError = contains (Pattern "Uniqueness violation")

data RawResponse a
  = Failure { errors :: Array { message :: String } }
  | Success { data :: a }

instance readGqlResponse :: ReadForeign a => ReadForeign (RawResponse a) where
  readImpl f = (Failure <$> JSON.readImpl f) <|> (Success <$> JSON.readImpl f)

mapErrors :: forall a. ReadForeign a => Either AjaxError (RawResponse a) -> Either Error a
mapErrors res = case res of
  Right (y :: RawResponse a) -> case y of
    Success a -> Right a.data
    Failure e -> Left (summarise e)
  Left e -> Left (show e)

summarise :: { errors :: Array { message :: String } } -> String
summarise e = String.joinWith " " (map _.message e.errors)

adminSecret :: RequestHeader
adminSecret = RequestHeader "x-hasura-admin-secret" Env.adminSecret
