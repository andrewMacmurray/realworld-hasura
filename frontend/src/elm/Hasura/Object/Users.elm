-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Object.Users exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Hasura.Enum.Articles_select_column
import Hasura.InputObject
import Hasura.Interface
import Hasura.Object
import Hasura.Scalar
import Hasura.ScalarCodecs
import Hasura.Union
import Json.Decode as Decode


type alias ArticlesOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Articles_select_column.Articles_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Articles_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Articles_bool_exp
    }


{-| An array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
articles : (ArticlesOptionalArguments -> ArticlesOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (List decodesTo) Hasura.Object.Users
articles fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Articles_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeArticles_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeArticles_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "articles" optionalArgs object_ (identity >> Decode.list)


email : SelectionSet String Hasura.Object.Users
email =
    Object.selectionForField "String" "email" [] Decode.string


username : SelectionSet String Hasura.Object.Users
username =
    Object.selectionForField "String" "username" [] Decode.string
