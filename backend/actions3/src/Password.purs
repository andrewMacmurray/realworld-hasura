module Password
  ( check
  , hash
  , checkCriteria
  ) where

import Prelude
import Crypto.Bcrypt (Hash)
import Crypto.Bcrypt as Bcrypt
import Data.Either (Either(..))
import Data.String.Regex (Regex)
import Data.String.Regex as Regex
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Users (User)

check :: String -> User -> Either String User
check password user =
  if Bcrypt.compare password user.password_hash then
    Right user
  else
    Left "Invalid username / password combination"

hash :: String -> Either String Hash
hash password =
  if checkCriteria password then
    Right (Bcrypt.hash password)
  else
    Left "Password does not meet criteria (at least 8 characters with lowercase, uppercase, numbers)"

checkCriteria :: String -> Boolean
checkCriteria = Regex.test criteriaRegex

criteriaRegex :: Regex
criteriaRegex = unsafeRegex (lower <> upper <> numbers <> above8) noFlags

lower :: String
lower = "(?=.*[a-z])"

upper :: String
upper = "(?=.*[A-Z])"

numbers :: String
numbers = "(?=.*[0-9])"

above8 :: String
above8 = "(?=.{8,})"
