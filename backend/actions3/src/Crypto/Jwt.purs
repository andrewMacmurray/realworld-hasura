module Crypto.Jwt (sign, Jwt) where

import Prelude
import Data.Newtype (class Newtype, unwrap)
import Simple.JSON (class WriteForeign, writeImpl)

newtype Jwt
  = Jwt String

derive instance newtypeJwt :: Newtype Jwt _

instance writeForeignJwt :: WriteForeign Jwt where
  writeImpl = unwrap >>> writeImpl

sign :: forall a. a -> Jwt
sign = sign_ >>> Jwt

foreign import sign_ :: forall a. a -> String

foreign import isValid :: String -> Boolean
