module Test.Password where

import Prelude
import Data.Either (Either(..))
import Password as Password
import Test.Unit (TestSuite, describe, test)
import Test.Unit.Assert as Assert

suite :: TestSuite
suite =
  describe "Password" do
    test "Checks password meets criteria" do
      Assert.equal
        (Right unit)
        (Password.checkCriteria "Abc123456")
    test "Short passwords" do
      Assert.equal
        (Left "Password does not meet criteria (at least 8 characters)")
        (Password.checkCriteria "Abc1234")
    test "Lower and uppercase" do
      Assert.equal
        (Left "Password does not meet criteria (contain uppercase, contain lowercase)")
        (Password.checkCriteria "12345678")
    test "Numbers" do
      Assert.equal
        (Left "Password does not meet criteria (contain numbers)")
        (Password.checkCriteria "ABCabcabc")
    test "Combines All errors" do
      Assert.equal
        (Left "Password does not meet criteria (at least 8 characters, contain uppercase, contain lowercase, contain numbers)")
        (Password.checkCriteria "?")
