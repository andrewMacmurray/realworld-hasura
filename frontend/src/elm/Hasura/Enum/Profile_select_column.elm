-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Enum.Profile_select_column exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| select columns of table "profile"

  - Bio - column name
  - Email - column name
  - Profile\_image - column name
  - User\_id - column name
  - Username - column name

-}
type Profile_select_column
    = Bio
    | Email
    | Profile_image
    | User_id
    | Username


list : List Profile_select_column
list =
    [ Bio, Email, Profile_image, User_id, Username ]


decoder : Decoder Profile_select_column
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "bio" ->
                        Decode.succeed Bio

                    "email" ->
                        Decode.succeed Email

                    "profile_image" ->
                        Decode.succeed Profile_image

                    "user_id" ->
                        Decode.succeed User_id

                    "username" ->
                        Decode.succeed Username

                    _ ->
                        Decode.fail ("Invalid Profile_select_column type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : Profile_select_column -> String
toString enum =
    case enum of
        Bio ->
            "bio"

        Email ->
            "email"

        Profile_image ->
            "profile_image"

        User_id ->
            "user_id"

        Username ->
            "username"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Profile_select_column
fromString enumString =
    case enumString of
        "bio" ->
            Just Bio

        "email" ->
            Just Email

        "profile_image" ->
            Just Profile_image

        "user_id" ->
            Just User_id

        "username" ->
            Just Username

        _ ->
            Nothing
