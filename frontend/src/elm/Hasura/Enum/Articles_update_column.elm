-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Articles_update_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| update columns of table "articles"

  - About - column name
  - Content - column name
  - Title - column name

-}
type Articles_update_column
    = About
    | Content
    | Title


list : List Articles_update_column
list =
    [ About, Content, Title ]


decoder : Decoder Articles_update_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "about" ->
                        Decode.succeed About

                    "content" ->
                        Decode.succeed Content

                    "title" ->
                        Decode.succeed Title

                    _ ->
                        Decode.fail ("Invalid Articles_update_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Articles_update_column -> String
toString enum =
    case enum of
        About ->
            "about"

        Content ->
            "content"

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
fromString : String -> Maybe Articles_update_column
fromString enumString =
    case enumString of
        "about" ->
            Just About

        "content" ->
            Just Content

        "title" ->
            Just Title

        _ ->
            Nothing
