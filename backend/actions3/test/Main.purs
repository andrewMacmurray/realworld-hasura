module Test.Main where

import Prelude
import Effect (Effect)
import Test.Login as Login
import Test.Password as Password
import Test.Unit.Main (runTest)

main :: Effect Unit
main =
  runTest do
    Password.suite
    Login.suite
