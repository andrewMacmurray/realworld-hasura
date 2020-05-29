-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Articles_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "articles"

  - About - column name
  - Content - column name
  - Created\_at - column name
  - Id - column name
  - Title - column name

-}
type Articles_select_column
    = About
    | Content
    | Created_at
    | Id
    | Title


list : List Articles_select_column
list =
    [ About, Content, Created_at, Id, Title ]


decoder : Decoder Articles_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "about" ->
                        Decode.succeed About

                    "content" ->
                        Decode.succeed Content

                    "created_at" ->
                        Decode.succeed Created_at

                    "id" ->
                        Decode.succeed Id

                    "title" ->
                        Decode.succeed Title

                    _ ->
                        Decode.fail ("Invalid Articles_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Articles_select_column -> String
toString enum =
    case enum of
        About ->
            "about"

        Content ->
            "content"

        Created_at ->
            "created_at"

        Id ->
            "id"

        Title ->
            "title"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Articles_select_column
fromString enumString =
    case enumString of
        "about" ->
            Just About

        "content" ->
            Just Content

        "created_at" ->
            Just Created_at

        "id" ->
            Just Id

        "title" ->
            Just Title

        _ ->
            Nothing
