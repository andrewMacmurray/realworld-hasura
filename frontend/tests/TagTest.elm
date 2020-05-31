module TagTest exposing (suite)

import Expect
import Tag exposing (Tag)
import Test exposing (describe, test)


suite : Test.Test
suite =
    describe "Tag.parse"
        [ test "Separates tags by characters other than letters and numbers" <|
            \_ ->
                Tag.parse "tag1, tag2,tag3!//&tag4"
                    |> expectTags
                        [ "tag1"
                        , "tag2"
                        , "tag3"
                        , "tag4"
                        ]
        , test "Handles empty input" <|
            \_ ->
                Tag.parse "" |> expectTags []
        , test "Removes duplicates" <|
            \_ ->
                Tag.parse "tag2, tag1, tag1, tag1" |> expectTags [ "tag2", "tag1" ]
        ]


expectTags : List String -> List Tag -> Expect.Expectation
expectTags =
    Expect.equal << tags


tags : List String -> List Tag
tags =
    List.map Tag.one
