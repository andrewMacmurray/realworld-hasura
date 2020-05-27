-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Query exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Hasura.Enum.Articles_select_column
import Hasura.Enum.Users_select_column
import Hasura.InputObject
import Hasura.Interface
import Hasura.Object
import Hasura.Scalar
import Hasura.ScalarCodecs
import Hasura.Union
import Json.Decode as Decode exposing (Decoder)


type alias ArticlesOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Articles_select_column.Articles_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Articles_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Articles_bool_exp
    }


{-| fetch data from the table: "articles"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
articles : (ArticlesOptionalArguments -> ArticlesOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (List decodesTo) RootQuery
articles fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Articles_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeArticles_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeArticles_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "articles" optionalArgs object_ (identity >> Decode.list)


type alias ArticlesByPkRequiredArguments =
    { id : Int }


{-| fetch data from the table: "articles" using primary key columns
-}
articles_by_pk : ArticlesByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (Maybe decodesTo) RootQuery
articles_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "articles_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


type alias UsersOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Users_select_column.Users_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Users_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Users_bool_exp
    }


{-| fetch data from the table: "users"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
users : (UsersOptionalArguments -> UsersOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Users -> SelectionSet (List decodesTo) RootQuery
users fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Users_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeUsers_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeUsers_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "users" optionalArgs object_ (identity >> Decode.list)


type alias UsersByPkRequiredArguments =
    { id : Int }


{-| fetch data from the table: "users" using primary key columns
-}
users_by_pk : UsersByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Users -> SelectionSet (Maybe decodesTo) RootQuery
users_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "users_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)
