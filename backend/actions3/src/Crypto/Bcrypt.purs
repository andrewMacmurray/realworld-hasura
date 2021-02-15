module Crypto.Bcrypt
  ( hash
  , compare
  , Hash
  ) where

import Prelude
import Data.Function.Uncurried (Fn2, runFn2)
import Data.Newtype (class Newtype, unwrap)

newtype Hash
  = Hash String

derive instance newtypeHash :: Newtype Hash _

hash :: String -> Hash
hash = hash_ >>> Hash

compare :: String -> Hash -> Boolean
compare password h = runFn2 compare_ password (unwrap h)

foreign import hash_ :: String -> String

foreign import compare_ :: Fn2 String String Boolean
