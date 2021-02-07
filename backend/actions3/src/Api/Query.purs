module Api.Query where

import Type.Row (type (+))
import GraphQLClient
  ( SelectionSet
  , Scope__RootQuery
  , selectionForCompositeField
  , toGraphQLArguments
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , Optional
  )
import Api.Scopes
  ( Scope__Articles
  , Scope__ArticlesAggregate
  , Scope__Comments
  , Scope__CommentsAggregate
  , Scope__Follows
  , Scope__FollowsAggregate
  , Scope__Likes
  , Scope__LikesAggregate
  , Scope__Profile
  , Scope__ProfileAggregate
  , Scope__Tags
  , Scope__TagsAggregate
  , Scope__Users
  , Scope__UsersAggregate
  )
import Data.Maybe (Maybe)
import Api.Enum.ArticlesSelectColumn (ArticlesSelectColumn)
import Api.InputObject
  ( ArticlesOrderBy
  , ArticlesBoolExp
  , CommentsOrderBy
  , CommentsBoolExp
  , FollowsOrderBy
  , FollowsBoolExp
  , LikesOrderBy
  , LikesBoolExp
  , ProfileOrderBy
  , ProfileBoolExp
  , TagsOrderBy
  , TagsBoolExp
  , UsersOrderBy
  , UsersBoolExp
  ) as Api.InputObject
import Api.Enum.CommentsSelectColumn (CommentsSelectColumn)
import Api.Enum.FollowsSelectColumn (FollowsSelectColumn)
import Api.Enum.LikesSelectColumn (LikesSelectColumn)
import Api.Enum.ProfileSelectColumn (ProfileSelectColumn)
import Api.Enum.TagsSelectColumn (TagsSelectColumn)
import Api.Enum.UsersSelectColumn (UsersSelectColumn)

type ArticleInputRowRequired r = ( id :: Int | r )

type ArticleInput = { | ArticleInputRowRequired + () }

article :: forall r . ArticleInput -> SelectionSet
                                      Scope__Articles
                                      r -> SelectionSet
                                           Scope__RootQuery
                                           (Maybe
                                            r)
article input = selectionForCompositeField
                "article"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type ArticlesInputRowOptional r = ( distinct_on :: Optional
                                                   (Array
                                                    ArticlesSelectColumn)
                                  , limit :: Optional Int
                                  , offset :: Optional Int
                                  , order_by :: Optional
                                                (Array
                                                 Api.InputObject.ArticlesOrderBy)
                                  , "where" :: Optional
                                               Api.InputObject.ArticlesBoolExp
                                  | r
                                  )

type ArticlesInput = { | ArticlesInputRowOptional + () }

articles :: forall r . ArticlesInput -> SelectionSet
                                        Scope__Articles
                                        r -> SelectionSet
                                             Scope__RootQuery
                                             (Array
                                              r)
articles input = selectionForCompositeField
                 "articles"
                 (toGraphQLArguments
                  input)
                 graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type ArticlesAggregateInputRowOptional r = ( distinct_on :: Optional
                                                            (Array
                                                             ArticlesSelectColumn)
                                           , limit :: Optional Int
                                           , offset :: Optional Int
                                           , order_by :: Optional
                                                         (Array
                                                          Api.InputObject.ArticlesOrderBy)
                                           , "where" :: Optional
                                                        Api.InputObject.ArticlesBoolExp
                                           | r
                                           )

type ArticlesAggregateInput = { | ArticlesAggregateInputRowOptional + () }

articles_aggregate :: forall r . ArticlesAggregateInput -> SelectionSet
                                                           Scope__ArticlesAggregate
                                                           r -> SelectionSet
                                                                Scope__RootQuery
                                                                r
articles_aggregate input = selectionForCompositeField
                           "articles_aggregate"
                           (toGraphQLArguments
                            input)
                           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CommentsInputRowOptional r = ( distinct_on :: Optional
                                                   (Array
                                                    CommentsSelectColumn)
                                  , limit :: Optional Int
                                  , offset :: Optional Int
                                  , order_by :: Optional
                                                (Array
                                                 Api.InputObject.CommentsOrderBy)
                                  , "where" :: Optional
                                               Api.InputObject.CommentsBoolExp
                                  | r
                                  )

type CommentsInput = { | CommentsInputRowOptional + () }

comments :: forall r . CommentsInput -> SelectionSet
                                        Scope__Comments
                                        r -> SelectionSet
                                             Scope__RootQuery
                                             (Array
                                              r)
comments input = selectionForCompositeField
                 "comments"
                 (toGraphQLArguments
                  input)
                 graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CommentsAggregateInputRowOptional r = ( distinct_on :: Optional
                                                            (Array
                                                             CommentsSelectColumn)
                                           , limit :: Optional Int
                                           , offset :: Optional Int
                                           , order_by :: Optional
                                                         (Array
                                                          Api.InputObject.CommentsOrderBy)
                                           , "where" :: Optional
                                                        Api.InputObject.CommentsBoolExp
                                           | r
                                           )

type CommentsAggregateInput = { | CommentsAggregateInputRowOptional + () }

comments_aggregate :: forall r . CommentsAggregateInput -> SelectionSet
                                                           Scope__CommentsAggregate
                                                           r -> SelectionSet
                                                                Scope__RootQuery
                                                                r
comments_aggregate input = selectionForCompositeField
                           "comments_aggregate"
                           (toGraphQLArguments
                            input)
                           graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type CommentsByPkInputRowRequired r = ( id :: Int | r )

type CommentsByPkInput = { | CommentsByPkInputRowRequired + () }

comments_by_pk :: forall r . CommentsByPkInput -> SelectionSet
                                                  Scope__Comments
                                                  r -> SelectionSet
                                                       Scope__RootQuery
                                                       (Maybe
                                                        r)
comments_by_pk input = selectionForCompositeField
                       "comments_by_pk"
                       (toGraphQLArguments
                        input)
                       graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowsInputRowOptional r = ( distinct_on :: Optional
                                                  (Array
                                                   FollowsSelectColumn)
                                 , limit :: Optional Int
                                 , offset :: Optional Int
                                 , order_by :: Optional
                                               (Array
                                                Api.InputObject.FollowsOrderBy)
                                 , "where" :: Optional
                                              Api.InputObject.FollowsBoolExp
                                 | r
                                 )

type FollowsInput = { | FollowsInputRowOptional + () }

follows :: forall r . FollowsInput -> SelectionSet
                                      Scope__Follows
                                      r -> SelectionSet
                                           Scope__RootQuery
                                           (Array
                                            r)
follows input = selectionForCompositeField
                "follows"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowsAggregateInputRowOptional r = ( distinct_on :: Optional
                                                           (Array
                                                            FollowsSelectColumn)
                                          , limit :: Optional Int
                                          , offset :: Optional Int
                                          , order_by :: Optional
                                                        (Array
                                                         Api.InputObject.FollowsOrderBy)
                                          , "where" :: Optional
                                                       Api.InputObject.FollowsBoolExp
                                          | r
                                          )

type FollowsAggregateInput = { | FollowsAggregateInputRowOptional + () }

follows_aggregate :: forall r . FollowsAggregateInput -> SelectionSet
                                                         Scope__FollowsAggregate
                                                         r -> SelectionSet
                                                              Scope__RootQuery
                                                              r
follows_aggregate input = selectionForCompositeField
                          "follows_aggregate"
                          (toGraphQLArguments
                           input)
                          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type FollowsByPkInputRowRequired r = ( id :: Int | r )

type FollowsByPkInput = { | FollowsByPkInputRowRequired + () }

follows_by_pk :: forall r . FollowsByPkInput -> SelectionSet
                                                Scope__Follows
                                                r -> SelectionSet
                                                     Scope__RootQuery
                                                     (Maybe
                                                      r)
follows_by_pk input = selectionForCompositeField
                      "follows_by_pk"
                      (toGraphQLArguments
                       input)
                      graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LikesInputRowOptional r = ( distinct_on :: Optional
                                                (Array
                                                 LikesSelectColumn)
                               , limit :: Optional Int
                               , offset :: Optional Int
                               , order_by :: Optional
                                             (Array
                                              Api.InputObject.LikesOrderBy)
                               , "where" :: Optional
                                            Api.InputObject.LikesBoolExp
                               | r
                               )

type LikesInput = { | LikesInputRowOptional + () }

likes :: forall r . LikesInput -> SelectionSet
                                  Scope__Likes
                                  r -> SelectionSet
                                       Scope__RootQuery
                                       (Array
                                        r)
likes input = selectionForCompositeField
              "likes"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LikesAggregateInputRowOptional r = ( distinct_on :: Optional
                                                         (Array
                                                          LikesSelectColumn)
                                        , limit :: Optional Int
                                        , offset :: Optional Int
                                        , order_by :: Optional
                                                      (Array
                                                       Api.InputObject.LikesOrderBy)
                                        , "where" :: Optional
                                                     Api.InputObject.LikesBoolExp
                                        | r
                                        )

type LikesAggregateInput = { | LikesAggregateInputRowOptional + () }

likes_aggregate :: forall r . LikesAggregateInput -> SelectionSet
                                                     Scope__LikesAggregate
                                                     r -> SelectionSet
                                                          Scope__RootQuery
                                                          r
likes_aggregate input = selectionForCompositeField
                        "likes_aggregate"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type LikesByPkInputRowRequired r = ( id :: Int | r )

type LikesByPkInput = { | LikesByPkInputRowRequired + () }

likes_by_pk :: forall r . LikesByPkInput -> SelectionSet
                                            Scope__Likes
                                            r -> SelectionSet
                                                 Scope__RootQuery
                                                 (Maybe
                                                  r)
likes_by_pk input = selectionForCompositeField
                    "likes_by_pk"
                    (toGraphQLArguments
                     input)
                    graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type ProfileInputRowOptional r = ( distinct_on :: Optional
                                                  (Array
                                                   ProfileSelectColumn)
                                 , limit :: Optional Int
                                 , offset :: Optional Int
                                 , order_by :: Optional
                                               (Array
                                                Api.InputObject.ProfileOrderBy)
                                 , "where" :: Optional
                                              Api.InputObject.ProfileBoolExp
                                 | r
                                 )

type ProfileInput = { | ProfileInputRowOptional + () }

profile :: forall r . ProfileInput -> SelectionSet
                                      Scope__Profile
                                      r -> SelectionSet
                                           Scope__RootQuery
                                           (Array
                                            r)
profile input = selectionForCompositeField
                "profile"
                (toGraphQLArguments
                 input)
                graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type ProfileAggregateInputRowOptional r = ( distinct_on :: Optional
                                                           (Array
                                                            ProfileSelectColumn)
                                          , limit :: Optional Int
                                          , offset :: Optional Int
                                          , order_by :: Optional
                                                        (Array
                                                         Api.InputObject.ProfileOrderBy)
                                          , "where" :: Optional
                                                       Api.InputObject.ProfileBoolExp
                                          | r
                                          )

type ProfileAggregateInput = { | ProfileAggregateInputRowOptional + () }

profile_aggregate :: forall r . ProfileAggregateInput -> SelectionSet
                                                         Scope__ProfileAggregate
                                                         r -> SelectionSet
                                                              Scope__RootQuery
                                                              r
profile_aggregate input = selectionForCompositeField
                          "profile_aggregate"
                          (toGraphQLArguments
                           input)
                          graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type TagInputRowRequired r = ( id :: Int | r )

type TagInput = { | TagInputRowRequired + () }

tag :: forall r . TagInput -> SelectionSet
                              Scope__Tags
                              r -> SelectionSet
                                   Scope__RootQuery
                                   (Maybe
                                    r)
tag input = selectionForCompositeField
            "tag"
            (toGraphQLArguments
             input)
            graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type TagsInputRowOptional r = ( distinct_on :: Optional (Array TagsSelectColumn)
                              , limit :: Optional Int
                              , offset :: Optional Int
                              , order_by :: Optional
                                            (Array
                                             Api.InputObject.TagsOrderBy)
                              , "where" :: Optional Api.InputObject.TagsBoolExp
                              | r
                              )

type TagsInput = { | TagsInputRowOptional + () }

tags :: forall r . TagsInput -> SelectionSet
                                Scope__Tags
                                r -> SelectionSet
                                     Scope__RootQuery
                                     (Array
                                      r)
tags input = selectionForCompositeField
             "tags"
             (toGraphQLArguments
              input)
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type TagsSummaryInputRowOptional r = ( distinct_on :: Optional
                                                      (Array
                                                       TagsSelectColumn)
                                     , limit :: Optional Int
                                     , offset :: Optional Int
                                     , order_by :: Optional
                                                   (Array
                                                    Api.InputObject.TagsOrderBy)
                                     , "where" :: Optional
                                                  Api.InputObject.TagsBoolExp
                                     | r
                                     )

type TagsSummaryInput = { | TagsSummaryInputRowOptional + () }

tags_summary :: forall r . TagsSummaryInput -> SelectionSet
                                               Scope__TagsAggregate
                                               r -> SelectionSet
                                                    Scope__RootQuery
                                                    r
tags_summary input = selectionForCompositeField
                     "tags_summary"
                     (toGraphQLArguments
                      input)
                     graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UserInputRowRequired r = ( id :: Int | r )

type UserInput = { | UserInputRowRequired + () }

user :: forall r . UserInput -> SelectionSet
                                Scope__Users
                                r -> SelectionSet
                                     Scope__RootQuery
                                     (Maybe
                                      r)
user input = selectionForCompositeField
             "user"
             (toGraphQLArguments
              input)
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UsersInputRowOptional r = ( distinct_on :: Optional
                                                (Array
                                                 UsersSelectColumn)
                               , limit :: Optional Int
                               , offset :: Optional Int
                               , order_by :: Optional
                                             (Array
                                              Api.InputObject.UsersOrderBy)
                               , "where" :: Optional
                                            Api.InputObject.UsersBoolExp
                               | r
                               )

type UsersInput = { | UsersInputRowOptional + () }

users :: forall r . UsersInput -> SelectionSet
                                  Scope__Users
                                  r -> SelectionSet
                                       Scope__RootQuery
                                       (Array
                                        r)
users input = selectionForCompositeField
              "users"
              (toGraphQLArguments
               input)
              graphqlDefaultResponseFunctorOrScalarDecoderTransformer

type UsersAggregateInputRowOptional r = ( distinct_on :: Optional
                                                         (Array
                                                          UsersSelectColumn)
                                        , limit :: Optional Int
                                        , offset :: Optional Int
                                        , order_by :: Optional
                                                      (Array
                                                       Api.InputObject.UsersOrderBy)
                                        , "where" :: Optional
                                                     Api.InputObject.UsersBoolExp
                                        | r
                                        )

type UsersAggregateInput = { | UsersAggregateInputRowOptional + () }

users_aggregate :: forall r . UsersAggregateInput -> SelectionSet
                                                     Scope__UsersAggregate
                                                     r -> SelectionSet
                                                          Scope__RootQuery
                                                          r
users_aggregate input = selectionForCompositeField
                        "users_aggregate"
                        (toGraphQLArguments
                         input)
                        graphqlDefaultResponseFunctorOrScalarDecoderTransformer
