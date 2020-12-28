module Api.Mutation where

import Type.Row (type (+))
import GraphQLClient
  ( SelectionSet
  , Scope__RootMutation
  , selectionForCompositeField
  , toGraphQLArguments
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , Optional
  )
import Api.Scopes
  ( Scope__Articles
  , Scope__ArticlesMutationResponse
  , Scope__Comments
  , Scope__CommentsMutationResponse
  , Scope__Follows
  , Scope__TagsMutationResponse
  , Scope__Tags
  , Scope__FollowsMutationResponse
  , Scope__Likes
  , Scope__LikesMutationResponse
  , Scope__TokenResponse
  , Scope__UnlikeResponse
  , Scope__Users
  , Scope__UsersMutationResponse
  )
import Data.Maybe (Maybe)
import Api.InputObject
  ( ArticlesBoolExp
  , CommentsBoolExp
  , TagsBoolExp
  , ArticlesSetInput
  , ArticlesPkColumnsInput
  , FollowsInsertInput
  , CommentsOnConflict
  , CommentsInsertInput
  , TagsInsertInput
  , LikesInsertInput
  , ArticlesOnConflict
  , ArticlesInsertInput
  , FollowsBoolExp
  , CommentsSetInput
  , CommentsPkColumnsInput
  , UsersSetInput
  , UsersPkColumnsInput
  , UsersBoolExp
  ) as Api.InputObject

type DeleteArticleInputRowRequired r = ( id :: Int | r )

type DeleteArticleInput = { | DeleteArticleInputRowRequired + () }

delete_article :: forall r . DeleteArticleInput -> SelectionSet
                                                   Scope__Articles
                                                   r -> SelectionSet
                                                        Scope__RootMutation
                                                        (Maybe
                                                         r)
delete_article input = selectionForCompositeField
                       "delete_article"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteArticlesInputRowRequired r = ( "where" :: Api.InputObject.ArticlesBoolExp
                                        | r
                                        )

type DeleteArticlesInput = { | DeleteArticlesInputRowRequired + () }

delete_articles :: forall r . DeleteArticlesInput -> SelectionSet
                                                     Scope__ArticlesMutationResponse
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
delete_articles input = selectionForCompositeField
                        "delete_articles"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteCommentInputRowRequired r = ( id :: Int | r )

type DeleteCommentInput = { | DeleteCommentInputRowRequired + () }

delete_comment :: forall r . DeleteCommentInput -> SelectionSet
                                                   Scope__Comments
                                                   r -> SelectionSet
                                                        Scope__RootMutation
                                                        (Maybe
                                                         r)
delete_comment input = selectionForCompositeField
                       "delete_comment"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteCommentsInputRowRequired r = ( "where" :: Api.InputObject.CommentsBoolExp
                                        | r
                                        )

type DeleteCommentsInput = { | DeleteCommentsInputRowRequired + () }

delete_comments :: forall r . DeleteCommentsInput -> SelectionSet
                                                     Scope__CommentsMutationResponse
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
delete_comments input = selectionForCompositeField
                        "delete_comments"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteFollowsByPkInputRowRequired r = ( id :: Int | r )

type DeleteFollowsByPkInput = { | DeleteFollowsByPkInputRowRequired + () }

delete_follows_by_pk :: forall r . DeleteFollowsByPkInput -> SelectionSet
                                                             Scope__Follows
                                                             r -> SelectionSet
                                                                  Scope__RootMutation
                                                                  (Maybe
                                                                   r)
delete_follows_by_pk input = selectionForCompositeField
                             "delete_follows_by_pk"
                             (toGraphQLArguments
                              input)
                             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteTagsInputRowRequired r = ( "where" :: Api.InputObject.TagsBoolExp
                                    | r
                                    )

type DeleteTagsInput = { | DeleteTagsInputRowRequired + () }

delete_tags :: forall r . DeleteTagsInput -> SelectionSet
                                             Scope__TagsMutationResponse
                                             r -> SelectionSet
                                                  Scope__RootMutation
                                                  (Maybe
                                                   r)
delete_tags input = selectionForCompositeField
                    "delete_tags"
                    (toGraphQLArguments
                     input)
                    graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type DeleteTagsByPkInputRowRequired r = ( id :: Int | r )

type DeleteTagsByPkInput = { | DeleteTagsByPkInputRowRequired + () }

delete_tags_by_pk :: forall r . DeleteTagsByPkInput -> SelectionSet
                                                       Scope__Tags
                                                       r -> SelectionSet
                                                            Scope__RootMutation
                                                            (Maybe
                                                             r)
delete_tags_by_pk input = selectionForCompositeField
                          "delete_tags_by_pk"
                          (toGraphQLArguments
                           input)
                          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type EditArticleInputRowOptional r = ( "_set" :: Optional
                                                 Api.InputObject.ArticlesSetInput
                                     | r
                                     )

type EditArticleInputRowRequired r = ( pk_columns :: Api.InputObject.ArticlesPkColumnsInput
                                     | r
                                     )

type EditArticleInput = {
| EditArticleInputRowOptional + EditArticleInputRowRequired + ()
}

edit_article :: forall r . EditArticleInput -> SelectionSet
                                               Scope__Articles
                                               r -> SelectionSet
                                                    Scope__RootMutation
                                                    (Maybe
                                                     r)
edit_article input = selectionForCompositeField
                     "edit_article"
                     (toGraphQLArguments
                      input)
                     graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowAuthorInputRowRequired r = ( object :: Api.InputObject.FollowsInsertInput
                                      | r
                                      )

type FollowAuthorInput = { | FollowAuthorInputRowRequired + () }

follow_author :: forall r . FollowAuthorInput -> SelectionSet
                                                 Scope__Follows
                                                 r -> SelectionSet
                                                      Scope__RootMutation
                                                      (Maybe
                                                       r)
follow_author input = selectionForCompositeField
                      "follow_author"
                      (toGraphQLArguments
                       input)
                      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowAuthorsInputRowRequired r = ( objects :: Array
                                                    Api.InputObject.FollowsInsertInput
                                       | r
                                       )

type FollowAuthorsInput = { | FollowAuthorsInputRowRequired + () }

follow_authors :: forall r . FollowAuthorsInput -> SelectionSet
                                                   Scope__FollowsMutationResponse
                                                   r -> SelectionSet
                                                        Scope__RootMutation
                                                        (Maybe
                                                         r)
follow_authors input = selectionForCompositeField
                       "follow_authors"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type InsertCommentsInputRowOptional r = ( on_conflict :: Optional
                                                         Api.InputObject.CommentsOnConflict
                                        | r
                                        )

type InsertCommentsInputRowRequired r = ( objects :: Array
                                                     Api.InputObject.CommentsInsertInput
                                        | r
                                        )

type InsertCommentsInput = {
| InsertCommentsInputRowOptional + InsertCommentsInputRowRequired + ()
}

insert_comments :: forall r . InsertCommentsInput -> SelectionSet
                                                     Scope__CommentsMutationResponse
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
insert_comments input = selectionForCompositeField
                        "insert_comments"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type InsertTagInputRowRequired r = ( object :: Api.InputObject.TagsInsertInput
                                   | r
                                   )

type InsertTagInput = { | InsertTagInputRowRequired + () }

insert_tag :: forall r . InsertTagInput -> SelectionSet
                                           Scope__Tags
                                           r -> SelectionSet
                                                Scope__RootMutation
                                                (Maybe
                                                 r)
insert_tag input = selectionForCompositeField
                   "insert_tag"
                   (toGraphQLArguments
                    input)
                   graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type InsertTagsInputRowRequired r = ( objects :: Array
                                                 Api.InputObject.TagsInsertInput
                                    | r
                                    )

type InsertTagsInput = { | InsertTagsInputRowRequired + () }

insert_tags :: forall r . InsertTagsInput -> SelectionSet
                                             Scope__TagsMutationResponse
                                             r -> SelectionSet
                                                  Scope__RootMutation
                                                  (Maybe
                                                   r)
insert_tags input = selectionForCompositeField
                    "insert_tags"
                    (toGraphQLArguments
                     input)
                    graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LikeArticleInputRowRequired r = ( object :: Api.InputObject.LikesInsertInput
                                     | r
                                     )

type LikeArticleInput = { | LikeArticleInputRowRequired + () }

like_article :: forall r . LikeArticleInput -> SelectionSet
                                               Scope__Likes
                                               r -> SelectionSet
                                                    Scope__RootMutation
                                                    (Maybe
                                                     r)
like_article input = selectionForCompositeField
                     "like_article"
                     (toGraphQLArguments
                      input)
                     graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LikeArticlesInputRowRequired r = ( objects :: Array
                                                   Api.InputObject.LikesInsertInput
                                      | r
                                      )

type LikeArticlesInput = { | LikeArticlesInputRowRequired + () }

like_articles :: forall r . LikeArticlesInput -> SelectionSet
                                                 Scope__LikesMutationResponse
                                                 r -> SelectionSet
                                                      Scope__RootMutation
                                                      (Maybe
                                                       r)
like_articles input = selectionForCompositeField
                      "like_articles"
                      (toGraphQLArguments
                       input)
                      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LoginInputRowRequired r = ( password :: String, username :: String | r )

type LoginInput = { | LoginInputRowRequired + () }

login :: forall r . LoginInput -> SelectionSet
                                  Scope__TokenResponse
                                  r -> SelectionSet
                                       Scope__RootMutation
                                       r
login input = selectionForCompositeField
              "login"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type PostCommentInputRowOptional r = ( on_conflict :: Optional
                                                      Api.InputObject.CommentsOnConflict
                                     | r
                                     )

type PostCommentInputRowRequired r = ( object :: Api.InputObject.CommentsInsertInput
                                     | r
                                     )

type PostCommentInput = {
| PostCommentInputRowOptional + PostCommentInputRowRequired + ()
}

post_comment :: forall r . PostCommentInput -> SelectionSet
                                               Scope__Comments
                                               r -> SelectionSet
                                                    Scope__RootMutation
                                                    (Maybe
                                                     r)
post_comment input = selectionForCompositeField
                     "post_comment"
                     (toGraphQLArguments
                      input)
                     graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type PublishArticleInputRowOptional r = ( on_conflict :: Optional
                                                         Api.InputObject.ArticlesOnConflict
                                        | r
                                        )

type PublishArticleInputRowRequired r = ( object :: Api.InputObject.ArticlesInsertInput
                                        | r
                                        )

type PublishArticleInput = {
| PublishArticleInputRowOptional + PublishArticleInputRowRequired + ()
}

publish_article :: forall r . PublishArticleInput -> SelectionSet
                                                     Scope__Articles
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
publish_article input = selectionForCompositeField
                        "publish_article"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type PublishArticlesInputRowOptional r = ( on_conflict :: Optional
                                                          Api.InputObject.ArticlesOnConflict
                                         | r
                                         )

type PublishArticlesInputRowRequired r = ( objects :: Array
                                                      Api.InputObject.ArticlesInsertInput
                                         | r
                                         )

type PublishArticlesInput = {
| PublishArticlesInputRowOptional + PublishArticlesInputRowRequired + ()
}

publish_articles :: forall r . PublishArticlesInput -> SelectionSet
                                                       Scope__ArticlesMutationResponse
                                                       r -> SelectionSet
                                                            Scope__RootMutation
                                                            (Maybe
                                                             r)
publish_articles input = selectionForCompositeField
                         "publish_articles"
                         (toGraphQLArguments
                          input)
                         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type SignupInputRowRequired r = ( email :: String
                                , password :: String
                                , username :: String
                                | r
                                )

type SignupInput = { | SignupInputRowRequired + () }

signup :: forall r . SignupInput -> SelectionSet
                                    Scope__TokenResponse
                                    r -> SelectionSet
                                         Scope__RootMutation
                                         r
signup input = selectionForCompositeField
               "signup"
               (toGraphQLArguments
                input)
               graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UnfollowAuthorsInputRowRequired r = ( "where" :: Api.InputObject.FollowsBoolExp
                                         | r
                                         )

type UnfollowAuthorsInput = { | UnfollowAuthorsInputRowRequired + () }

unfollow_authors :: forall r . UnfollowAuthorsInput -> SelectionSet
                                                       Scope__FollowsMutationResponse
                                                       r -> SelectionSet
                                                            Scope__RootMutation
                                                            (Maybe
                                                             r)
unfollow_authors input = selectionForCompositeField
                         "unfollow_authors"
                         (toGraphQLArguments
                          input)
                         graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UnlikeArticleInputRowRequired r = ( article_id :: Int | r )

type UnlikeArticleInput = { | UnlikeArticleInputRowRequired + () }

unlike_article :: forall r . UnlikeArticleInput -> SelectionSet
                                                   Scope__UnlikeResponse
                                                   r -> SelectionSet
                                                        Scope__RootMutation
                                                        r
unlike_article input = selectionForCompositeField
                       "unlike_article"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UpdateArticlesInputRowOptional r = ( "_set" :: Optional
                                                    Api.InputObject.ArticlesSetInput
                                        | r
                                        )

type UpdateArticlesInputRowRequired r = ( "where" :: Api.InputObject.ArticlesBoolExp
                                        | r
                                        )

type UpdateArticlesInput = {
| UpdateArticlesInputRowOptional + UpdateArticlesInputRowRequired + ()
}

update_articles :: forall r . UpdateArticlesInput -> SelectionSet
                                                     Scope__ArticlesMutationResponse
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
update_articles input = selectionForCompositeField
                        "update_articles"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UpdateCommentInputRowOptional r = ( "_set" :: Optional
                                                   Api.InputObject.CommentsSetInput
                                       | r
                                       )

type UpdateCommentInputRowRequired r = ( pk_columns :: Api.InputObject.CommentsPkColumnsInput
                                       | r
                                       )

type UpdateCommentInput = {
| UpdateCommentInputRowOptional + UpdateCommentInputRowRequired + ()
}

update_comment :: forall r . UpdateCommentInput -> SelectionSet
                                                   Scope__Comments
                                                   r -> SelectionSet
                                                        Scope__RootMutation
                                                        (Maybe
                                                         r)
update_comment input = selectionForCompositeField
                       "update_comment"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UpdateCommentsInputRowOptional r = ( "_set" :: Optional
                                                    Api.InputObject.CommentsSetInput
                                        | r
                                        )

type UpdateCommentsInputRowRequired r = ( "where" :: Api.InputObject.CommentsBoolExp
                                        | r
                                        )

type UpdateCommentsInput = {
| UpdateCommentsInputRowOptional + UpdateCommentsInputRowRequired + ()
}

update_comments :: forall r . UpdateCommentsInput -> SelectionSet
                                                     Scope__CommentsMutationResponse
                                                     r -> SelectionSet
                                                          Scope__RootMutation
                                                          (Maybe
                                                           r)
update_comments input = selectionForCompositeField
                        "update_comments"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UpdateUserInputRowOptional r = ( "_set" :: Optional
                                                Api.InputObject.UsersSetInput
                                    | r
                                    )

type UpdateUserInputRowRequired r = ( pk_columns :: Api.InputObject.UsersPkColumnsInput
                                    | r
                                    )

type UpdateUserInput = {
| UpdateUserInputRowOptional + UpdateUserInputRowRequired + ()
}

update_user :: forall r . UpdateUserInput -> SelectionSet
                                             Scope__Users
                                             r -> SelectionSet
                                                  Scope__RootMutation
                                                  (Maybe
                                                   r)
update_user input = selectionForCompositeField
                    "update_user"
                    (toGraphQLArguments
                     input)
                    graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UpdateUsersInputRowOptional r = ( "_set" :: Optional
                                                 Api.InputObject.UsersSetInput
                                     | r
                                     )

type UpdateUsersInputRowRequired r = ( "where" :: Api.InputObject.UsersBoolExp
                                     | r
                                     )

type UpdateUsersInput = {
| UpdateUsersInputRowOptional + UpdateUsersInputRowRequired + ()
}

update_users :: forall r . UpdateUsersInput -> SelectionSet
                                               Scope__UsersMutationResponse
                                               r -> SelectionSet
                                                    Scope__RootMutation
                                                    (Maybe
                                                     r)
update_users input = selectionForCompositeField
                     "update_users"
                     (toGraphQLArguments
                      input)
                     graphqlDefaultResponseFunctorOrScalarDecoderTransformer
