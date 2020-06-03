-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Object.Likes_var_samp_fields exposing (..)

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


article_id : SelectionSet (Maybe Float) Hasura.Object.Likes_var_samp_fields
article_id =
    Object.selectionForField "(Maybe Float)" "article_id" [] (Decode.float |> Decode.nullable)


user_id : SelectionSet (Maybe Float) Hasura.Object.Likes_var_samp_fields
user_id =
    Object.selectionForField "(Maybe Float)" "user_id" [] (Decode.float |> Decode.nullable)
