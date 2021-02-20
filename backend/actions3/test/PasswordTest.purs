module Test.Main where

import Prelude
import Effect (Effect)
import Password as Password
import Test.Unit (test)
import Test.Unit.Assert as Assert
import Test.Unit.Main (runTest)

main :: Effect Unit
main =
  runTest do
    test "Checks password meets criteria" do
      Assert.assert "Password should passs" (Password.checkCriteria "Abc12345!")
    test "Short passwords" do
      Assert.assertFalse "Password should fail" (Password.checkCriteria "Abc1234")
