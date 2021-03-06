-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Object.Comments exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Hasura.InputObject
import Hasura.Interface
import Hasura.Object
import Hasura.Scalar
import Hasura.ScalarCodecs
import Hasura.Union
import Json.Decode as Decode


{-| An object relationship
-}
article : SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet decodesTo Hasura.Object.Comments
article object_ =
    Object.selectionForCompositeField "article" [] object_ identity


comment : SelectionSet String Hasura.Object.Comments
comment =
    Object.selectionForField "String" "comment" [] Decode.string


created_at : SelectionSet Hasura.ScalarCodecs.Timestamptz Hasura.Object.Comments
created_at =
    Object.selectionForField "ScalarCodecs.Timestamptz" "created_at" [] (Hasura.ScalarCodecs.codecs |> Hasura.Scalar.unwrapCodecs |> .codecTimestamptz |> .decoder)


id : SelectionSet Int Hasura.Object.Comments
id =
    Object.selectionForField "Int" "id" [] Decode.int


{-| An object relationship
-}
user : SelectionSet decodesTo Hasura.Object.Users -> SelectionSet decodesTo Hasura.Object.Comments
user object_ =
    Object.selectionForCompositeField "user" [] object_ identity
