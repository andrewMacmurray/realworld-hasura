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


type alias DeleteCommentsRequiredArguments =
    { where_ : Hasura.InputObject.Comments_bool_exp }


{-| delete data from the table: "comments"

  - where\_ - filter the rows which have to be deleted

-}
delete_comments : DeleteCommentsRequiredArguments -> SelectionSet decodesTo Hasura.Object.Comments_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
delete_comments requiredArgs object_ =
    Object.selectionForCompositeField "delete_comments" [ Argument.required "where" requiredArgs.where_ Hasura.InputObject.encodeComments_bool_exp ] object_ (identity >> Decode.nullable)


type alias DeleteCommentsByPkRequiredArguments =
    { id : Int }


{-| delete single row from the table: "comments"
-}
delete_comments_by_pk : DeleteCommentsByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Comments -> SelectionSet (Maybe decodesTo) RootMutation
delete_comments_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "delete_comments_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


type alias DeleteFollowsByPkRequiredArguments =
    { id : Int }


{-| delete single row from the table: "follows"
-}
delete_follows_by_pk : DeleteFollowsByPkRequiredArguments -> SelectionSet decodesTo Hasura.Object.Follows -> SelectionSet (Maybe decodesTo) RootMutation
delete_follows_by_pk requiredArgs object_ =
    Object.selectionForCompositeField "delete_follows_by_pk" [ Argument.required "id" requiredArgs.id Encode.int ] object_ (identity >> Decode.nullable)


type alias FollowAuthorRequiredArguments =
    { object : Hasura.InputObject.Follows_insert_input }


{-| insert a single row into the table: "follows"

  - object - the row to be inserted

-}
follow_author : FollowAuthorRequiredArguments -> SelectionSet decodesTo Hasura.Object.Follows -> SelectionSet (Maybe decodesTo) RootMutation
follow_author requiredArgs object_ =
    Object.selectionForCompositeField "follow_author" [ Argument.required "object" requiredArgs.object Hasura.InputObject.encodeFollows_insert_input ] object_ (identity >> Decode.nullable)


type alias FollowAuthorsRequiredArguments =
    { objects : List Hasura.InputObject.Follows_insert_input }


{-| insert data into the table: "follows"

  - objects - the rows to be inserted

-}
follow_authors : FollowAuthorsRequiredArguments -> SelectionSet decodesTo Hasura.Object.Follows_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
follow_authors requiredArgs object_ =
    Object.selectionForCompositeField "follow_authors" [ Argument.required "objects" requiredArgs.objects (Hasura.InputObject.encodeFollows_insert_input |> Encode.list) ] object_ (identity >> Decode.nullable)


type alias InsertCommentsRequiredArguments =
    { objects : List Hasura.InputObject.Comments_insert_input }


{-| insert data into the table: "comments"

  - objects - the rows to be inserted

-}
insert_comments : InsertCommentsRequiredArguments -> SelectionSet decodesTo Hasura.Object.Comments_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_comments requiredArgs object_ =
    Object.selectionForCompositeField "insert_comments" [ Argument.required "objects" requiredArgs.objects (Hasura.InputObject.encodeComments_insert_input |> Encode.list) ] object_ (identity >> Decode.nullable)


type alias InsertTagRequiredArguments =
    { object : Hasura.InputObject.Tags_insert_input }


{-| insert a single row into the table: "tags"

  - object - the row to be inserted

-}
insert_tag : InsertTagRequiredArguments -> SelectionSet decodesTo Hasura.Object.Tags -> SelectionSet (Maybe decodesTo) RootMutation
insert_tag requiredArgs object_ =
    Object.selectionForCompositeField "insert_tag" [ Argument.required "object" requiredArgs.object Hasura.InputObject.encodeTags_insert_input ] object_ (identity >> Decode.nullable)


type alias InsertTagsRequiredArguments =
    { objects : List Hasura.InputObject.Tags_insert_input }


{-| insert data into the table: "tags"

  - objects - the rows to be inserted

-}
insert_tags : InsertTagsRequiredArguments -> SelectionSet decodesTo Hasura.Object.Tags_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
insert_tags requiredArgs object_ =
    Object.selectionForCompositeField "insert_tags" [ Argument.required "objects" requiredArgs.objects (Hasura.InputObject.encodeTags_insert_input |> Encode.list) ] object_ (identity >> Decode.nullable)


type alias LikeArticleRequiredArguments =
    { object : Hasura.InputObject.Likes_insert_input }


{-| insert a single row into the table: "likes"

  - object - the row to be inserted

-}
like_article : LikeArticleRequiredArguments -> SelectionSet decodesTo Hasura.Object.Likes -> SelectionSet (Maybe decodesTo) RootMutation
like_article requiredArgs object_ =
    Object.selectionForCompositeField "like_article" [ Argument.required "object" requiredArgs.object Hasura.InputObject.encodeLikes_insert_input ] object_ (identity >> Decode.nullable)


type alias LikeArticlesRequiredArguments =
    { objects : List Hasura.InputObject.Likes_insert_input }


{-| insert data into the table: "likes"

  - objects - the rows to be inserted

-}
like_articles : LikeArticlesRequiredArguments -> SelectionSet decodesTo Hasura.Object.Likes_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
like_articles requiredArgs object_ =
    Object.selectionForCompositeField "like_articles" [ Argument.required "objects" requiredArgs.objects (Hasura.InputObject.encodeLikes_insert_input |> Encode.list) ] object_ (identity >> Decode.nullable)


type alias LoginRequiredArguments =
    { password : String
    , username : String
    }


{-| perform the action: "login"
-}
login : LoginRequiredArguments -> SelectionSet decodesTo Hasura.Object.TokenResponse -> SelectionSet decodesTo RootMutation
login requiredArgs object_ =
    Object.selectionForCompositeField "login" [ Argument.required "password" requiredArgs.password Encode.string, Argument.required "username" requiredArgs.username Encode.string ] object_ identity


type alias PostCommentRequiredArguments =
    { object : Hasura.InputObject.Comments_insert_input }


{-| insert a single row into the table: "comments"

  - object - the row to be inserted

-}
post_comment : PostCommentRequiredArguments -> SelectionSet decodesTo Hasura.Object.Comments -> SelectionSet (Maybe decodesTo) RootMutation
post_comment requiredArgs object_ =
    Object.selectionForCompositeField "post_comment" [ Argument.required "object" requiredArgs.object Hasura.InputObject.encodeComments_insert_input ] object_ (identity >> Decode.nullable)


type alias PublishArticleOptionalArguments =
    { on_conflict : OptionalArgument Hasura.InputObject.Articles_on_conflict }


type alias PublishArticleRequiredArguments =
    { object : Hasura.InputObject.Articles_insert_input }


{-| insert a single row into the table: "articles"

  - object - the row to be inserted
  - on\_conflict - on conflict condition

-}
publish_article : (PublishArticleOptionalArguments -> PublishArticleOptionalArguments) -> PublishArticleRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles -> SelectionSet (Maybe decodesTo) RootMutation
publish_article fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Hasura.InputObject.encodeArticles_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "publish_article" (optionalArgs ++ [ Argument.required "object" requiredArgs.object Hasura.InputObject.encodeArticles_insert_input ]) object_ (identity >> Decode.nullable)


type alias PublishArticlesOptionalArguments =
    { on_conflict : OptionalArgument Hasura.InputObject.Articles_on_conflict }


type alias PublishArticlesRequiredArguments =
    { objects : List Hasura.InputObject.Articles_insert_input }


{-| insert data into the table: "articles"

  - objects - the rows to be inserted
  - on\_conflict - on conflict condition

-}
publish_articles : (PublishArticlesOptionalArguments -> PublishArticlesOptionalArguments) -> PublishArticlesRequiredArguments -> SelectionSet decodesTo Hasura.Object.Articles_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
publish_articles fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { on_conflict = Absent }

        optionalArgs =
            [ Argument.optional "on_conflict" filledInOptionals.on_conflict Hasura.InputObject.encodeArticles_on_conflict ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "publish_articles" (optionalArgs ++ [ Argument.required "objects" requiredArgs.objects (Hasura.InputObject.encodeArticles_insert_input |> Encode.list) ]) object_ (identity >> Decode.nullable)


type alias SignupRequiredArguments =
    { email : String
    , password : String
    , username : String
    }


{-| perform the action: "signup"
-}
signup : SignupRequiredArguments -> SelectionSet decodesTo Hasura.Object.TokenResponse -> SelectionSet decodesTo RootMutation
signup requiredArgs object_ =
    Object.selectionForCompositeField "signup" [ Argument.required "email" requiredArgs.email Encode.string, Argument.required "password" requiredArgs.password Encode.string, Argument.required "username" requiredArgs.username Encode.string ] object_ identity


type alias UnfollowAuthorsRequiredArguments =
    { where_ : Hasura.InputObject.Follows_bool_exp }


{-| delete data from the table: "follows"

  - where\_ - filter the rows which have to be deleted

-}
unfollow_authors : UnfollowAuthorsRequiredArguments -> SelectionSet decodesTo Hasura.Object.Follows_mutation_response -> SelectionSet (Maybe decodesTo) RootMutation
unfollow_authors requiredArgs object_ =
    Object.selectionForCompositeField "unfollow_authors" [ Argument.required "where" requiredArgs.where_ Hasura.InputObject.encodeFollows_bool_exp ] object_ (identity >> Decode.nullable)


type alias UnlikeArticleRequiredArguments =
    { article_id : Int }


{-| perform the action: "unlike\_article"
-}
unlike_article : UnlikeArticleRequiredArguments -> SelectionSet decodesTo Hasura.Object.UnlikeResponse -> SelectionSet decodesTo RootMutation
unlike_article requiredArgs object_ =
    Object.selectionForCompositeField "unlike_article" [ Argument.required "article_id" requiredArgs.article_id Encode.int ] object_ identity


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
