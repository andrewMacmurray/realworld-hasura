module Test.Login where

import Test.Unit (TestSuite, describe, test)
import Test.Unit.Assert as Assert

suite :: TestSuite
suite =
  describe "Login" do
    test "Does a thing" do
      Assert.equal 1 1
