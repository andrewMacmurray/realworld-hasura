module Crypto.Jwt (sign, Jwt) where

import Prelude
import Simple.JSON (class WriteForeign, writeImpl)

newtype Jwt
  = Jwt String

instance writeForeignJwt :: WriteForeign Jwt where
  writeImpl (Jwt s) = writeImpl s

sign :: forall a. a -> Jwt
sign = sign_ >>> Jwt

foreign import sign_ :: forall a. a -> String
