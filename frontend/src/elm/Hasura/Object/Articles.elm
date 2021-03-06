-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Object.Articles exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Hasura.Enum.Comments_select_column
import Hasura.Enum.Likes_select_column
import Hasura.Enum.Tags_select_column
import Hasura.InputObject
import Hasura.Interface
import Hasura.Object
import Hasura.Scalar
import Hasura.ScalarCodecs
import Hasura.Union
import Json.Decode as Decode


about : SelectionSet String Hasura.Object.Articles
about =
    Object.selectionForField "String" "about" [] Decode.string


{-| An object relationship
-}
author : SelectionSet decodesTo Hasura.Object.Users -> SelectionSet decodesTo Hasura.Object.Articles
author object_ =
    Object.selectionForCompositeField "author" [] object_ identity


type alias CommentsOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Comments_select_column.Comments_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Comments_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Comments_bool_exp
    }


{-| An array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
comments : (CommentsOptionalArguments -> CommentsOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Comments -> SelectionSet (List decodesTo) Hasura.Object.Articles
comments fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Comments_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeComments_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeComments_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "comments" optionalArgs object_ (identity >> Decode.list)


content : SelectionSet String Hasura.Object.Articles
content =
    Object.selectionForField "String" "content" [] Decode.string


created_at : SelectionSet Hasura.ScalarCodecs.Timestamptz Hasura.Object.Articles
created_at =
    Object.selectionForField "ScalarCodecs.Timestamptz" "created_at" [] (Hasura.ScalarCodecs.codecs |> Hasura.Scalar.unwrapCodecs |> .codecTimestamptz |> .decoder)


id : SelectionSet Int Hasura.Object.Articles
id =
    Object.selectionForField "Int" "id" [] Decode.int


type alias LikesOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Likes_select_column.Likes_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Likes_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Likes_bool_exp
    }


{-| An array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
likes : (LikesOptionalArguments -> LikesOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Likes -> SelectionSet (List decodesTo) Hasura.Object.Articles
likes fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Likes_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeLikes_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeLikes_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "likes" optionalArgs object_ (identity >> Decode.list)


type alias LikesAggregateOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Likes_select_column.Likes_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Likes_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Likes_bool_exp
    }


{-| An aggregated array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
likes_aggregate : (LikesAggregateOptionalArguments -> LikesAggregateOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Likes_aggregate -> SelectionSet decodesTo Hasura.Object.Articles
likes_aggregate fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Likes_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeLikes_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeLikes_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "likes_aggregate" optionalArgs object_ identity


type alias TagsOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Tags_select_column.Tags_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Tags_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Tags_bool_exp
    }


{-| An array relationship

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
tags : (TagsOptionalArguments -> TagsOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Tags -> SelectionSet (List decodesTo) Hasura.Object.Articles
tags fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Tags_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeTags_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeTags_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "tags" optionalArgs object_ (identity >> Decode.list)


title : SelectionSet String Hasura.Object.Articles
title =
    Object.selectionForField "String" "title" [] Decode.string
