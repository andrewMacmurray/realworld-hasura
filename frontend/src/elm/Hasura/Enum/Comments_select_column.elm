-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Comments_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "comments"

  - Comment - column name
  - Created\_at - column name
  - Id - column name

-}
type Comments_select_column
    = Comment
    | Created_at
    | Id


list : List Comments_select_column
list =
    [ Comment, Created_at, Id ]


decoder : Decoder Comments_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "comment" ->
                        Decode.succeed Comment

                    "created_at" ->
                        Decode.succeed Created_at

                    "id" ->
                        Decode.succeed Id

                    _ ->
                        Decode.fail ("Invalid Comments_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Comments_select_column -> String
toString enum =
    case enum of
        Comment ->
            "comment"

        Created_at ->
            "created_at"

        Id ->
            "id"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Comments_select_column
fromString enumString =
    case enumString of
        "comment" ->
            Just Comment

        "created_at" ->
            Just Created_at

        "id" ->
            Just Id

        _ ->
            Nothing
