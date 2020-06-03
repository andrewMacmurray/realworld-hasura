-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Subscription exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Hasura.Enum.Articles_select_column
import Hasura.Enum.Likes_select_column
import Hasura.Enum.Tags_select_column
import Hasura.Enum.User_profile_select_column
import Hasura.Enum.Users_select_column
import Hasura.InputObject
import Hasura.Interface
import Hasura.Object
import Hasura.Scalar
import Hasura.ScalarCodecs
import Hasura.Union
import Json.Decode as Decode exposing (Decoder)


type alias ArticleRequiredArguments =
    { id : Int }


{-| fetch data from the table: "articles" using primary key columns
-}
article : ArticleRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (Maybe decodesTo) RootSubscription
article requiredArgs object_ =
    Object.selectionForCompositeField "article" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


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
articles : (ArticlesOptionalArguments -> ArticlesOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (List decodesTo) RootSubscription
articles fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Articles_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeArticles_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeArticles_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "articles" optionalArgs object_ (identity >> Decode.list)


type alias LikesOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Likes_select_column.Likes_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Likes_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Likes_bool_exp
    }


{-| fetch data from the table: "likes"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
likes : (LikesOptionalArguments -> LikesOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Likes -> SelectionSet (List decodesTo) RootSubscription
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


{-| fetch aggregated fields from the table: "likes"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
likes_aggregate : (LikesAggregateOptionalArguments -> LikesAggregateOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Likes_aggregate -> SelectionSet decodesTo RootSubscription
likes_aggregate fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Likes_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeLikes_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeLikes_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "likes_aggregate" optionalArgs object_ identity


type alias LikesByPkRequiredArguments =
    { id : Int }


{-| fetch data from the table: "likes" using primary key columns
-}
likes_by_pk : LikesByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Likes -> SelectionSet (Maybe decodesTo) RootSubscription
likes_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "likes_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


type alias ProfileOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.User_profile_select_column.User_profile_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.User_profile_order_by)
    , where_ : OptionalArgument Hasura.InputObject.User_profile_bool_exp
    }


{-| fetch data from the table: "user\_profile"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
profile : (ProfileOptionalArguments -> ProfileOptionalArguments) -> SelectionSet decodesTo Hasura.Object.User_profile -> SelectionSet (List decodesTo) RootSubscription
profile fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.User_profile_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeUser_profile_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeUser_profile_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "profile" optionalArgs object_ (identity >> Decode.list)


type alias TagRequiredArguments =
    { id : Int }


{-| fetch data from the table: "tags" using primary key columns
-}
tag : TagRequiredArguments -> SelectionSet decodesTo Hasura.Object.Tags -> SelectionSet (Maybe decodesTo) RootSubscription
tag requiredArgs object_ =
    Object.selectionForCompositeField "tag" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


type alias TagsOptionalArguments =
    { distinct_on : OptionalArgument (List Hasura.Enum.Tags_select_column.Tags_select_column)
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    , order_by : OptionalArgument (List Hasura.InputObject.Tags_order_by)
    , where_ : OptionalArgument Hasura.InputObject.Tags_bool_exp
    }


{-| fetch data from the table: "tags"

  - distinct\_on - distinct select on columns
  - limit - limit the number of rows returned
  - offset - skip the first n rows. Use only with order\_by
  - order\_by - sort the rows by one or more columns
  - where\_ - filter the rows returned

-}
tags : (TagsOptionalArguments -> TagsOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Tags -> SelectionSet (List decodesTo) RootSubscription
tags fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { distinct_on = Absent, limit = Absent, offset = Absent, order_by = Absent, where_ = Absent }

        optionalArgs =
            [ Argument.optional "distinct_on" filledInOptionals.distinct_on (Encode.enum Hasura.Enum.Tags_select_column.toString |> Encode.list), Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "order_by" filledInOptionals.order_by (Hasura.InputObject.encodeTags_order_by |> Encode.list), Argument.optional "where" filledInOptionals.where_ Hasura.InputObject.encodeTags_bool_exp ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "tags" optionalArgs object_ (identity >> Decode.list)


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
users : (UsersOptionalArguments -> UsersOptionalArguments) -> SelectionSet decodesTo Hasura.Object.Users -> SelectionSet (List decodesTo) RootSubscription
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
users_by_pk : UsersByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Users -> SelectionSet (Maybe decodesTo) RootSubscription
users_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "users_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)
