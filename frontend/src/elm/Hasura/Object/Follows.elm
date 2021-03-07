-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Object.Follows exposing (..)

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


following_id : SelectionSet Int Hasura.Object.Follows
following_id =
    Object.selectionForField "Int" "following_id" [] Decode.int


{-| An object relationship
-}
user : SelectionSet decodesTo Hasura.Object.Users -> SelectionSet decodesTo Hasura.Object.Follows
user object_ =
    Object.selectionForCompositeField "user" [] object_ identity
