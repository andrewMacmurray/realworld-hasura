module Crypto.Bcrypt
  ( hash
  , compare
  , Hash
  ) where

import Prelude
import Data.Function.Uncurried (Fn2, runFn2)
import Data.Newtype (class Newtype, unwrap, wrap)
import Simple.JSON (class ReadForeign, class WriteForeign, readImpl, writeImpl)

newtype Hash
  = Hash String

derive instance newtypeHash :: Newtype Hash _

instance readHash :: ReadForeign Hash where
  readImpl f = Hash <$> readImpl f

instance writeHash :: WriteForeign Hash where
  writeImpl = unwrap >>> writeImpl

hash :: String -> Hash
hash = hash_ >>> wrap

compare :: String -> Hash -> Boolean
compare password h = runFn2 compare_ password (unwrap h)

foreign import hash_ :: String -> String

foreign import compare_ :: Fn2 String String Boolean
