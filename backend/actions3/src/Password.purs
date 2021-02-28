module Password
  ( check
  , hash
  , checkCriteria
  ) where

import Prelude
import Crypto.Bcrypt (Hash)
import Crypto.Bcrypt as Bcrypt
import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Data.Newtype (class Newtype, unwrap)
import Data.String as Array
import Data.String.Regex as Regex
import Data.String.Regex.Flags (noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)
import Users (User)

-- Check
check :: String -> User -> Either String User
check password user =
  if Bcrypt.compare password user.password_hash then
    Right user
  else
    Left "Invalid username / password combination"

-- Hash
hash :: String -> Either String Hash
hash password = const (Bcrypt.hash password) <$> checkCriteria password

checkCriteria :: String -> Either String Unit
checkCriteria password = lmap errorMessage (runChecks password)

errorMessage :: Array String -> String
errorMessage errs = "Password does not meet criteria (" <> (Array.joinWith ", " errs) <> ")"

-- Criteria
newtype Criteria e a
  = Criteria (Either e a)

derive instance criteriaF :: Functor (Criteria e)

derive instance criteriaNew :: Newtype (Criteria e a) _

instance criteriaAppl :: Monoid e => Applicative (Criteria e) where
  pure = Criteria <<< pure

instance criterialApp :: (Monoid e) => Apply (Criteria e) where
  apply (Criteria (Left x)) (Criteria (Left y)) = Criteria (Left (x <> y))
  apply (Criteria x) (Criteria y) = Criteria (x <*> y)

runChecks :: String -> Either (Array String) Unit
runChecks password =
  unwrap
    ( above8 password
        *> upper password
        *> lower password
        *> numbers password
    )

lower :: String -> Criteria (Array String) Unit
lower =
  criteria
    { regex: "(?=.*[a-z])"
    , error: "contain lowercase"
    }

upper :: String -> Criteria (Array String) Unit
upper =
  criteria
    { regex: "(?=.*[A-Z])"
    , error: "contain uppercase"
    }

numbers :: String -> Criteria (Array String) Unit
numbers =
  criteria
    { regex: "(?=.*[0-9])"
    , error: "contain numbers"
    }

above8 :: String -> Criteria (Array String) Unit
above8 =
  criteria
    { regex: "(?=.{8,})"
    , error: "at least 8 characters"
    }

criteria :: { regex :: String, error :: String } -> String -> Criteria (Array String) Unit
criteria config password =
  if Regex.test (unsafeRegex config.regex noFlags) password then
    pure unit
  else
    Criteria (Left [ config.error ])
