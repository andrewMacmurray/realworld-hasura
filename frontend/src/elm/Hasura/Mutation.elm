-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Hasura.Mutation exposing (..)

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
import Json.Decode as Decode exposing (Decoder)


type alias LoginRequiredArguments =
    { password : String
    , username : String
    }


{-| perform the action: "login"
-}
login : LoginRequiredArguments -> SelectionSet decodesTo Hasura.Object.Token -> SelectionSet decodesTo RootMutation
login requiredArgs object_ =
    Object.selectionForCompositeField "login" [ Argument.required "password" requiredArgs.password Encode.string, Argument.required "username" requiredArgs.username Encode.string ] object_ identity


type alias SignupRequiredArguments =
    { email : String
    , password : String
    , username : String
    }


{-| perform the action: "signup"
-}
signup : SignupRequiredArguments -> SelectionSet decodesTo Hasura.Object.Token -> SelectionSet decodesTo RootMutation
signup requiredArgs object_ =
    Object.selectionForCompositeField "signup" [ Argument.required "email" requiredArgs.email Encode.string, Argument.required "password" requiredArgs.password Encode.string, Argument.required "username" requiredArgs.username Encode.string ] object_ identity


type alias UpdateArticlesOptionalArguments =
    { set_ : OptionalArgument Hasura.InputObject.Articles_set_input }


type alias UpdateArticlesRequiredArguments =
    { where_ : Hasura.InputObject.Articles_bool_exp }


{-| update data of the table: "articles"

  - set\_ - sets the columns of the filtered rows to the given values
  - where\_ - filter the rows which have to be updated

-}
update_articles : (UpdateArticlesOptionalArguments -> UpdateArticlesOptionalArguments) -> UpdateArticlesRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
update_articles fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { set_ = Absent }

        optionalArgs =
            [ Argument.optional "_set" filledInOptionals.set_ Hasura.InputObject.encodeArticles_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_articles" (optionalArgs ++ [ Argument.required "where" requiredArgs.where_ Hasura.InputObject.encodeArticles_bool_exp ]) object_ (identity >> Decode.nullable)


type alias UpdateArticlesByPkOptionalArguments =
    { set_ : OptionalArgument Hasura.InputObject.Articles_set_input }


type alias UpdateArticlesByPkRequiredArguments =
    { pk_columns : Hasura.InputObject.Articles_pk_columns_input }


{-| update single row of the table: "articles"

  - set\_ - sets the columns of the filtered rows to the given values

-}
update_articles_by_pk : (UpdateArticlesByPkOptionalArguments -> UpdateArticlesByPkOptionalArguments) -> UpdateArticlesByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (Maybe decodesTo) RootMutation
update_articles_by_pk fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { set_ = Absent }

        optionalArgs =
            [ Argument.optional "_set" filledInOptionals.set_ Hasura.InputObject.encodeArticles_set_input ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "update_articles_by_pk" (optionalArgs ++ [ Argument.required "pk_columns" requiredArgs.pk_columns Hasura.InputObject.encodeArticles_pk_columns_input ]) object_ (identity >> Decode.nullable)
