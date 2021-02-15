module Password (check) where

import Crypto.Bcrypt as Bcrypt
import Data.Either (Either(..))
import Users (User)

check :: String -> User -> Either String User
check password user =
  if Bcrypt.compare password user.password then
    Right user
  else
    Left "login error"
