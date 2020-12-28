module Api.Object.Articles where

import GraphQLClient
  ( SelectionSet
  , selectionForField
  , graphqlDefaultResponseScalarDecoder
  , selectionForCompositeField
  , graphqlDefaultResponseFunctorOrScalarDecoderTransformer
  , Optional
  , toGraphQLArguments
  )
import Api.Scopes
  ( Scope__Articles
  , Scope__Users
  , Scope__Comments
  , Scope__Likes
  , Scope__LikesAggregate
  , Scope__Tags
  )
import Api.Enum.CommentsSelectColumn (CommentsSelectColumn)
import Api.InputObject
  ( CommentsOrderBy
  , CommentsBoolExp
  , LikesOrderBy
  , LikesBoolExp
  , TagsOrderBy
  , TagsBoolExp
  ) as Api.InputObject
import Type.Row (type (+))
import Api.Scalars (Timestamptz)
import Api.Enum.LikesSelectColumn (LikesSelectColumn)
import Api.Enum.TagsSelectColumn (TagsSelectColumn)

about :: SelectionSet Scope__Articles String
about = selectionForField "about" [] graphqlDefaultResponseScalarDecoder

author :: forall r . SelectionSet
                     Scope__Users
                     r -> SelectionSet
                          Scope__Articles
                          r
author = selectionForCompositeField
         "author"
         []
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
                                             Scope__Articles
                                             (Array
                                              r)
comments input = selectionForCompositeField
                 "comments"
                 (toGraphQLArguments
                  input)
                 graphqlDefaultResponseFunctorOrScalarDecoderTransformer

content :: SelectionSet Scope__Articles String
content = selectionForField "content" [] graphqlDefaultResponseScalarDecoder

created_at :: SelectionSet Scope__Articles Timestamptz
created_at = selectionForField
             "created_at"
             []
             graphqlDefaultResponseScalarDecoder

id :: SelectionSet Scope__Articles Int
id = selectionForField "id" [] graphqlDefaultResponseScalarDecoder

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
                                       Scope__Articles
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
                                                          Scope__Articles
                                                          r
likes_aggregate input = selectionForCompositeField
                        "likes_aggregate"
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
                                     Scope__Articles
                                     (Array
                                      r)
tags input = selectionForCompositeField
             "tags"
             (toGraphQLArguments
              input)
             graphqlDefaultResponseFunctorOrScalarDecoderTransformer

title :: SelectionSet Scope__Articles String
title = selectionForField "title" [] graphqlDefaultResponseScalarDecoder
