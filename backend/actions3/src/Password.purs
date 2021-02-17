module Password
  ( check
  , hash
  ) where

import Crypto.Bcrypt (Hash)
import Crypto.Bcrypt as Bcrypt
import Data.Either (Either(..))
import Users (User)

check :: String -> User -> Either String User
check password user =
  if Bcrypt.compare password user.password_hash then
    Right user
  else
    Left "Invalid username / password combination"

hash :: String -> Either String Hash
hash password =
  if matchesCriteria password then
    Right (Bcrypt.hash password)
  else
    Left "Password does not meet criteria (at least 8 characters with lowercase, uppercase, numbers)"

matchesCriteria :: String -> Boolean
matchesCriteria password = true
