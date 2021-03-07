-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Comments_update_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| update columns of table "comments"

  - Comment - column name

-}
type Comments_update_column
    = Comment


list : List Comments_update_column
list =
    [ Comment ]


decoder : Decoder Comments_update_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "comment" ->
                        Decode.succeed Comment

                    _ ->
                        Decode.fail ("Invalid Comments_update_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Comments_update_column -> String
toString enum =
    case enum of
        Comment ->
            "comment"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Comments_update_column
fromString enumString =
    case enumString of
        "comment" ->
            Just Comment

        _ ->
            Nothing
