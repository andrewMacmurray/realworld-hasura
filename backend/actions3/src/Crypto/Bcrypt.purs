module Crypto.Bcrypt (hash, Hash) where

import Prelude
import Data.Newtype (class Newtype)

newtype Hash
  = Hash String

derive instance newtypeHash :: Newtype Hash _

hash :: String -> Hash
hash = hash_ >>> Hash

foreign import hash_ :: String -> String
