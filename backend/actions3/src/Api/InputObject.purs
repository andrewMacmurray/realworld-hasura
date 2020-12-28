module Api.InputObject where

import GraphQLClient
  (Optional, class ToGraphQLArgumentValue, toGraphQLArgumentValue)
import Data.Generic.Rep (class Generic)
import Data.Newtype (class Newtype)
import Api.Enum.OrderBy (OrderBy)
import Data.Maybe (Maybe)
import Api.Enum.ArticlesConstraint (ArticlesConstraint)
import Api.Enum.ArticlesUpdateColumn (ArticlesUpdateColumn)
import Api.Enum.CommentsConstraint (CommentsConstraint)
import Api.Enum.CommentsUpdateColumn (CommentsUpdateColumn)
import Api.Scalars (Json, Timestamptz)
import Api.Enum.UsersConstraint (UsersConstraint)
import Api.Enum.UsersUpdateColumn (UsersUpdateColumn)

-- | original name - Int_comparison_exp
newtype IntComparisonExp = IntComparisonExp { "_eq" :: Optional Int
                                            , "_gt" :: Optional Int
                                            , "_gte" :: Optional Int
                                            , "_in" :: Optional (Array Int)
                                            , "_is_null" :: Optional Boolean
                                            , "_lt" :: Optional Int
                                            , "_lte" :: Optional Int
                                            , "_neq" :: Optional Int
                                            , "_nin" :: Optional (Array Int)
                                            }

derive instance genericIntComparisonExp :: Generic IntComparisonExp _

derive instance newtypeIntComparisonExp :: Newtype IntComparisonExp _

instance toGraphQLArgumentValueIntComparisonExp :: ToGraphQLArgumentValue
                                                   IntComparisonExp where
  toGraphQLArgumentValue (IntComparisonExp x) = toGraphQLArgumentValue x

-- | original name - String_comparison_exp
newtype StringComparisonExp = StringComparisonExp { "_eq" :: Optional String
                                                  , "_gt" :: Optional String
                                                  , "_gte" :: Optional String
                                                  , "_ilike" :: Optional String
                                                  , "_in" :: Optional
                                                             (Array
                                                              String)
                                                  , "_is_null" :: Optional
                                                                  Boolean
                                                  , "_like" :: Optional String
                                                  , "_lt" :: Optional String
                                                  , "_lte" :: Optional String
                                                  , "_neq" :: Optional String
                                                  , "_nilike" :: Optional String
                                                  , "_nin" :: Optional
                                                              (Array
                                                               String)
                                                  , "_nlike" :: Optional String
                                                  , "_nsimilar" :: Optional
                                                                   String
                                                  , "_similar" :: Optional
                                                                  String
                                                  }

derive instance genericStringComparisonExp :: Generic StringComparisonExp _

derive instance newtypeStringComparisonExp :: Newtype StringComparisonExp _

instance toGraphQLArgumentValueStringComparisonExp :: ToGraphQLArgumentValue
                                                      StringComparisonExp where
  toGraphQLArgumentValue (StringComparisonExp x) = toGraphQLArgumentValue x

-- | original name - articles_aggregate_order_by
newtype ArticlesAggregateOrderBy = ArticlesAggregateOrderBy { avg :: Optional
                                                                     ArticlesAvgOrderBy
                                                            , count :: Optional
                                                                       OrderBy
                                                            , max :: Optional
                                                                     ArticlesMaxOrderBy
                                                            , min :: Optional
                                                                     ArticlesMinOrderBy
                                                            , stddev :: Optional
                                                                        ArticlesStddevOrderBy
                                                            , stddev_pop :: Optional
                                                                            ArticlesStddevPopOrderBy
                                                            , stddev_samp :: Optional
                                                                             ArticlesStddevSampOrderBy
                                                            , sum :: Optional
                                                                     ArticlesSumOrderBy
                                                            , var_pop :: Optional
                                                                         ArticlesVarPopOrderBy
                                                            , var_samp :: Optional
                                                                          ArticlesVarSampOrderBy
                                                            , variance :: Optional
                                                                          ArticlesVarianceOrderBy
                                                            }

derive instance genericArticlesAggregateOrderBy :: Generic ArticlesAggregateOrderBy _

derive instance newtypeArticlesAggregateOrderBy :: Newtype ArticlesAggregateOrderBy _

instance toGraphQLArgumentValueArticlesAggregateOrderBy :: ToGraphQLArgumentValue
                                                           ArticlesAggregateOrderBy where
  toGraphQLArgumentValue (ArticlesAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_arr_rel_insert_input
newtype ArticlesArrRelInsertInput = ArticlesArrRelInsertInput { "data" :: Array
                                                                          ArticlesInsertInput
                                                              , on_conflict :: Optional
                                                                               ArticlesOnConflict
                                                              }

derive instance genericArticlesArrRelInsertInput :: Generic ArticlesArrRelInsertInput _

derive instance newtypeArticlesArrRelInsertInput :: Newtype ArticlesArrRelInsertInput _

instance toGraphQLArgumentValueArticlesArrRelInsertInput :: ToGraphQLArgumentValue
                                                            ArticlesArrRelInsertInput where
  toGraphQLArgumentValue (ArticlesArrRelInsertInput x) = toGraphQLArgumentValue
                                                         x

-- | original name - articles_avg_order_by
newtype ArticlesAvgOrderBy = ArticlesAvgOrderBy { id :: Optional OrderBy }

derive instance genericArticlesAvgOrderBy :: Generic ArticlesAvgOrderBy _

derive instance newtypeArticlesAvgOrderBy :: Newtype ArticlesAvgOrderBy _

instance toGraphQLArgumentValueArticlesAvgOrderBy :: ToGraphQLArgumentValue
                                                     ArticlesAvgOrderBy where
  toGraphQLArgumentValue (ArticlesAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_bool_exp
newtype ArticlesBoolExp = ArticlesBoolExp { "_and" :: Optional
                                                      (Array
                                                       (Maybe
                                                        ArticlesBoolExp))
                                          , "_not" :: Optional ArticlesBoolExp
                                          , "_or" :: Optional
                                                     (Array
                                                      (Maybe
                                                       ArticlesBoolExp))
                                          , about :: Optional
                                                     StringComparisonExp
                                          , author :: Optional UsersBoolExp
                                          , comments :: Optional CommentsBoolExp
                                          , content :: Optional
                                                       StringComparisonExp
                                          , created_at :: Optional
                                                          TimestamptzComparisonExp
                                          , id :: Optional IntComparisonExp
                                          , likes :: Optional LikesBoolExp
                                          , tags :: Optional TagsBoolExp
                                          , title :: Optional
                                                     StringComparisonExp
                                          }

derive instance genericArticlesBoolExp :: Generic ArticlesBoolExp _

derive instance newtypeArticlesBoolExp :: Newtype ArticlesBoolExp _

instance toGraphQLArgumentValueArticlesBoolExp :: ToGraphQLArgumentValue
                                                  ArticlesBoolExp where
  toGraphQLArgumentValue (ArticlesBoolExp x) = toGraphQLArgumentValue x

-- | original name - articles_insert_input
newtype ArticlesInsertInput = ArticlesInsertInput { about :: Optional String
                                                  , comments :: Optional
                                                                CommentsArrRelInsertInput
                                                  , content :: Optional String
                                                  , likes :: Optional
                                                             LikesArrRelInsertInput
                                                  , tags :: Optional
                                                            TagsArrRelInsertInput
                                                  , title :: Optional String
                                                  }

derive instance genericArticlesInsertInput :: Generic ArticlesInsertInput _

derive instance newtypeArticlesInsertInput :: Newtype ArticlesInsertInput _

instance toGraphQLArgumentValueArticlesInsertInput :: ToGraphQLArgumentValue
                                                      ArticlesInsertInput where
  toGraphQLArgumentValue (ArticlesInsertInput x) = toGraphQLArgumentValue x

-- | original name - articles_max_order_by
newtype ArticlesMaxOrderBy = ArticlesMaxOrderBy { about :: Optional OrderBy
                                                , content :: Optional OrderBy
                                                , created_at :: Optional OrderBy
                                                , id :: Optional OrderBy
                                                , title :: Optional OrderBy
                                                }

derive instance genericArticlesMaxOrderBy :: Generic ArticlesMaxOrderBy _

derive instance newtypeArticlesMaxOrderBy :: Newtype ArticlesMaxOrderBy _

instance toGraphQLArgumentValueArticlesMaxOrderBy :: ToGraphQLArgumentValue
                                                     ArticlesMaxOrderBy where
  toGraphQLArgumentValue (ArticlesMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_min_order_by
newtype ArticlesMinOrderBy = ArticlesMinOrderBy { about :: Optional OrderBy
                                                , content :: Optional OrderBy
                                                , created_at :: Optional OrderBy
                                                , id :: Optional OrderBy
                                                , title :: Optional OrderBy
                                                }

derive instance genericArticlesMinOrderBy :: Generic ArticlesMinOrderBy _

derive instance newtypeArticlesMinOrderBy :: Newtype ArticlesMinOrderBy _

instance toGraphQLArgumentValueArticlesMinOrderBy :: ToGraphQLArgumentValue
                                                     ArticlesMinOrderBy where
  toGraphQLArgumentValue (ArticlesMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_obj_rel_insert_input
newtype ArticlesObjRelInsertInput = ArticlesObjRelInsertInput { "data" :: ArticlesInsertInput
                                                              , on_conflict :: Optional
                                                                               ArticlesOnConflict
                                                              }

derive instance genericArticlesObjRelInsertInput :: Generic ArticlesObjRelInsertInput _

derive instance newtypeArticlesObjRelInsertInput :: Newtype ArticlesObjRelInsertInput _

instance toGraphQLArgumentValueArticlesObjRelInsertInput :: ToGraphQLArgumentValue
                                                            ArticlesObjRelInsertInput where
  toGraphQLArgumentValue (ArticlesObjRelInsertInput x) = toGraphQLArgumentValue
                                                         x

-- | original name - articles_on_conflict
newtype ArticlesOnConflict = ArticlesOnConflict { constraint :: ArticlesConstraint
                                                , update_columns :: Array
                                                                    ArticlesUpdateColumn
                                                , "where" :: Optional
                                                             ArticlesBoolExp
                                                }

derive instance genericArticlesOnConflict :: Generic ArticlesOnConflict _

derive instance newtypeArticlesOnConflict :: Newtype ArticlesOnConflict _

instance toGraphQLArgumentValueArticlesOnConflict :: ToGraphQLArgumentValue
                                                     ArticlesOnConflict where
  toGraphQLArgumentValue (ArticlesOnConflict x) = toGraphQLArgumentValue x

-- | original name - articles_order_by
newtype ArticlesOrderBy = ArticlesOrderBy { about :: Optional OrderBy
                                          , author :: Optional UsersOrderBy
                                          , content :: Optional OrderBy
                                          , created_at :: Optional OrderBy
                                          , id :: Optional OrderBy
                                          , likes_aggregate :: Optional
                                                               LikesAggregateOrderBy
                                          , title :: Optional OrderBy
                                          }

derive instance genericArticlesOrderBy :: Generic ArticlesOrderBy _

derive instance newtypeArticlesOrderBy :: Newtype ArticlesOrderBy _

instance toGraphQLArgumentValueArticlesOrderBy :: ToGraphQLArgumentValue
                                                  ArticlesOrderBy where
  toGraphQLArgumentValue (ArticlesOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_pk_columns_input
newtype ArticlesPkColumnsInput = ArticlesPkColumnsInput { id :: Int }

derive instance genericArticlesPkColumnsInput :: Generic ArticlesPkColumnsInput _

derive instance newtypeArticlesPkColumnsInput :: Newtype ArticlesPkColumnsInput _

instance toGraphQLArgumentValueArticlesPkColumnsInput :: ToGraphQLArgumentValue
                                                         ArticlesPkColumnsInput where
  toGraphQLArgumentValue (ArticlesPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - articles_set_input
newtype ArticlesSetInput = ArticlesSetInput { about :: Optional String
                                            , content :: Optional String
                                            , title :: Optional String
                                            }

derive instance genericArticlesSetInput :: Generic ArticlesSetInput _

derive instance newtypeArticlesSetInput :: Newtype ArticlesSetInput _

instance toGraphQLArgumentValueArticlesSetInput :: ToGraphQLArgumentValue
                                                   ArticlesSetInput where
  toGraphQLArgumentValue (ArticlesSetInput x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_order_by
newtype ArticlesStddevOrderBy = ArticlesStddevOrderBy { id :: Optional OrderBy }

derive instance genericArticlesStddevOrderBy :: Generic ArticlesStddevOrderBy _

derive instance newtypeArticlesStddevOrderBy :: Newtype ArticlesStddevOrderBy _

instance toGraphQLArgumentValueArticlesStddevOrderBy :: ToGraphQLArgumentValue
                                                        ArticlesStddevOrderBy where
  toGraphQLArgumentValue (ArticlesStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_pop_order_by
newtype ArticlesStddevPopOrderBy = ArticlesStddevPopOrderBy { id :: Optional
                                                                    OrderBy
                                                            }

derive instance genericArticlesStddevPopOrderBy :: Generic ArticlesStddevPopOrderBy _

derive instance newtypeArticlesStddevPopOrderBy :: Newtype ArticlesStddevPopOrderBy _

instance toGraphQLArgumentValueArticlesStddevPopOrderBy :: ToGraphQLArgumentValue
                                                           ArticlesStddevPopOrderBy where
  toGraphQLArgumentValue (ArticlesStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_samp_order_by
newtype ArticlesStddevSampOrderBy = ArticlesStddevSampOrderBy { id :: Optional
                                                                      OrderBy
                                                              }

derive instance genericArticlesStddevSampOrderBy :: Generic ArticlesStddevSampOrderBy _

derive instance newtypeArticlesStddevSampOrderBy :: Newtype ArticlesStddevSampOrderBy _

instance toGraphQLArgumentValueArticlesStddevSampOrderBy :: ToGraphQLArgumentValue
                                                            ArticlesStddevSampOrderBy where
  toGraphQLArgumentValue (ArticlesStddevSampOrderBy x) = toGraphQLArgumentValue
                                                         x

-- | original name - articles_sum_order_by
newtype ArticlesSumOrderBy = ArticlesSumOrderBy { id :: Optional OrderBy }

derive instance genericArticlesSumOrderBy :: Generic ArticlesSumOrderBy _

derive instance newtypeArticlesSumOrderBy :: Newtype ArticlesSumOrderBy _

instance toGraphQLArgumentValueArticlesSumOrderBy :: ToGraphQLArgumentValue
                                                     ArticlesSumOrderBy where
  toGraphQLArgumentValue (ArticlesSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_var_pop_order_by
newtype ArticlesVarPopOrderBy = ArticlesVarPopOrderBy { id :: Optional OrderBy }

derive instance genericArticlesVarPopOrderBy :: Generic ArticlesVarPopOrderBy _

derive instance newtypeArticlesVarPopOrderBy :: Newtype ArticlesVarPopOrderBy _

instance toGraphQLArgumentValueArticlesVarPopOrderBy :: ToGraphQLArgumentValue
                                                        ArticlesVarPopOrderBy where
  toGraphQLArgumentValue (ArticlesVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_var_samp_order_by
newtype ArticlesVarSampOrderBy = ArticlesVarSampOrderBy { id :: Optional OrderBy
                                                        }

derive instance genericArticlesVarSampOrderBy :: Generic ArticlesVarSampOrderBy _

derive instance newtypeArticlesVarSampOrderBy :: Newtype ArticlesVarSampOrderBy _

instance toGraphQLArgumentValueArticlesVarSampOrderBy :: ToGraphQLArgumentValue
                                                         ArticlesVarSampOrderBy where
  toGraphQLArgumentValue (ArticlesVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_variance_order_by
newtype ArticlesVarianceOrderBy = ArticlesVarianceOrderBy { id :: Optional
                                                                  OrderBy
                                                          }

derive instance genericArticlesVarianceOrderBy :: Generic ArticlesVarianceOrderBy _

derive instance newtypeArticlesVarianceOrderBy :: Newtype ArticlesVarianceOrderBy _

instance toGraphQLArgumentValueArticlesVarianceOrderBy :: ToGraphQLArgumentValue
                                                          ArticlesVarianceOrderBy where
  toGraphQLArgumentValue (ArticlesVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_arr_rel_insert_input
newtype CommentsArrRelInsertInput = CommentsArrRelInsertInput { "data" :: Array
                                                                          CommentsInsertInput
                                                              , on_conflict :: Optional
                                                                               CommentsOnConflict
                                                              }

derive instance genericCommentsArrRelInsertInput :: Generic CommentsArrRelInsertInput _

derive instance newtypeCommentsArrRelInsertInput :: Newtype CommentsArrRelInsertInput _

instance toGraphQLArgumentValueCommentsArrRelInsertInput :: ToGraphQLArgumentValue
                                                            CommentsArrRelInsertInput where
  toGraphQLArgumentValue (CommentsArrRelInsertInput x) = toGraphQLArgumentValue
                                                         x

-- | original name - comments_bool_exp
newtype CommentsBoolExp = CommentsBoolExp { "_and" :: Optional
                                                      (Array
                                                       (Maybe
                                                        CommentsBoolExp))
                                          , "_not" :: Optional CommentsBoolExp
                                          , "_or" :: Optional
                                                     (Array
                                                      (Maybe
                                                       CommentsBoolExp))
                                          , article :: Optional ArticlesBoolExp
                                          , comment :: Optional
                                                       StringComparisonExp
                                          , created_at :: Optional
                                                          TimestamptzComparisonExp
                                          , id :: Optional IntComparisonExp
                                          , user :: Optional UsersBoolExp
                                          }

derive instance genericCommentsBoolExp :: Generic CommentsBoolExp _

derive instance newtypeCommentsBoolExp :: Newtype CommentsBoolExp _

instance toGraphQLArgumentValueCommentsBoolExp :: ToGraphQLArgumentValue
                                                  CommentsBoolExp where
  toGraphQLArgumentValue (CommentsBoolExp x) = toGraphQLArgumentValue x

-- | original name - comments_insert_input
newtype CommentsInsertInput = CommentsInsertInput { article :: Optional
                                                               ArticlesObjRelInsertInput
                                                  , article_id :: Optional Int
                                                  , comment :: Optional String
                                                  }

derive instance genericCommentsInsertInput :: Generic CommentsInsertInput _

derive instance newtypeCommentsInsertInput :: Newtype CommentsInsertInput _

instance toGraphQLArgumentValueCommentsInsertInput :: ToGraphQLArgumentValue
                                                      CommentsInsertInput where
  toGraphQLArgumentValue (CommentsInsertInput x) = toGraphQLArgumentValue x

-- | original name - comments_obj_rel_insert_input
newtype CommentsObjRelInsertInput = CommentsObjRelInsertInput { "data" :: CommentsInsertInput
                                                              , on_conflict :: Optional
                                                                               CommentsOnConflict
                                                              }

derive instance genericCommentsObjRelInsertInput :: Generic CommentsObjRelInsertInput _

derive instance newtypeCommentsObjRelInsertInput :: Newtype CommentsObjRelInsertInput _

instance toGraphQLArgumentValueCommentsObjRelInsertInput :: ToGraphQLArgumentValue
                                                            CommentsObjRelInsertInput where
  toGraphQLArgumentValue (CommentsObjRelInsertInput x) = toGraphQLArgumentValue
                                                         x

-- | original name - comments_on_conflict
newtype CommentsOnConflict = CommentsOnConflict { constraint :: CommentsConstraint
                                                , update_columns :: Array
                                                                    CommentsUpdateColumn
                                                , "where" :: Optional
                                                             CommentsBoolExp
                                                }

derive instance genericCommentsOnConflict :: Generic CommentsOnConflict _

derive instance newtypeCommentsOnConflict :: Newtype CommentsOnConflict _

instance toGraphQLArgumentValueCommentsOnConflict :: ToGraphQLArgumentValue
                                                     CommentsOnConflict where
  toGraphQLArgumentValue (CommentsOnConflict x) = toGraphQLArgumentValue x

-- | original name - comments_order_by
newtype CommentsOrderBy = CommentsOrderBy { article :: Optional ArticlesOrderBy
                                          , comment :: Optional OrderBy
                                          , created_at :: Optional OrderBy
                                          , id :: Optional OrderBy
                                          , user :: Optional UsersOrderBy
                                          }

derive instance genericCommentsOrderBy :: Generic CommentsOrderBy _

derive instance newtypeCommentsOrderBy :: Newtype CommentsOrderBy _

instance toGraphQLArgumentValueCommentsOrderBy :: ToGraphQLArgumentValue
                                                  CommentsOrderBy where
  toGraphQLArgumentValue (CommentsOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_pk_columns_input
newtype CommentsPkColumnsInput = CommentsPkColumnsInput { id :: Int }

derive instance genericCommentsPkColumnsInput :: Generic CommentsPkColumnsInput _

derive instance newtypeCommentsPkColumnsInput :: Newtype CommentsPkColumnsInput _

instance toGraphQLArgumentValueCommentsPkColumnsInput :: ToGraphQLArgumentValue
                                                         CommentsPkColumnsInput where
  toGraphQLArgumentValue (CommentsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - comments_set_input
newtype CommentsSetInput = CommentsSetInput { comment :: Optional String }

derive instance genericCommentsSetInput :: Generic CommentsSetInput _

derive instance newtypeCommentsSetInput :: Newtype CommentsSetInput _

instance toGraphQLArgumentValueCommentsSetInput :: ToGraphQLArgumentValue
                                                   CommentsSetInput where
  toGraphQLArgumentValue (CommentsSetInput x) = toGraphQLArgumentValue x

-- | original name - follows_arr_rel_insert_input
newtype FollowsArrRelInsertInput = FollowsArrRelInsertInput { "data" :: Array
                                                                        FollowsInsertInput
                                                            }

derive instance genericFollowsArrRelInsertInput :: Generic FollowsArrRelInsertInput _

derive instance newtypeFollowsArrRelInsertInput :: Newtype FollowsArrRelInsertInput _

instance toGraphQLArgumentValueFollowsArrRelInsertInput :: ToGraphQLArgumentValue
                                                           FollowsArrRelInsertInput where
  toGraphQLArgumentValue (FollowsArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_bool_exp
newtype FollowsBoolExp = FollowsBoolExp { "_and" :: Optional
                                                    (Array
                                                     (Maybe
                                                      FollowsBoolExp))
                                        , "_not" :: Optional FollowsBoolExp
                                        , "_or" :: Optional
                                                   (Array
                                                    (Maybe
                                                     FollowsBoolExp))
                                        , following_id :: Optional
                                                          IntComparisonExp
                                        , user :: Optional UsersBoolExp
                                        }

derive instance genericFollowsBoolExp :: Generic FollowsBoolExp _

derive instance newtypeFollowsBoolExp :: Newtype FollowsBoolExp _

instance toGraphQLArgumentValueFollowsBoolExp :: ToGraphQLArgumentValue
                                                 FollowsBoolExp where
  toGraphQLArgumentValue (FollowsBoolExp x) = toGraphQLArgumentValue x

-- | original name - follows_insert_input
newtype FollowsInsertInput = FollowsInsertInput { following_id :: Optional Int }

derive instance genericFollowsInsertInput :: Generic FollowsInsertInput _

derive instance newtypeFollowsInsertInput :: Newtype FollowsInsertInput _

instance toGraphQLArgumentValueFollowsInsertInput :: ToGraphQLArgumentValue
                                                     FollowsInsertInput where
  toGraphQLArgumentValue (FollowsInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_obj_rel_insert_input
newtype FollowsObjRelInsertInput = FollowsObjRelInsertInput { "data" :: FollowsInsertInput
                                                            }

derive instance genericFollowsObjRelInsertInput :: Generic FollowsObjRelInsertInput _

derive instance newtypeFollowsObjRelInsertInput :: Newtype FollowsObjRelInsertInput _

instance toGraphQLArgumentValueFollowsObjRelInsertInput :: ToGraphQLArgumentValue
                                                           FollowsObjRelInsertInput where
  toGraphQLArgumentValue (FollowsObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_order_by
newtype FollowsOrderBy = FollowsOrderBy { following_id :: Optional OrderBy
                                        , user :: Optional UsersOrderBy
                                        }

derive instance genericFollowsOrderBy :: Generic FollowsOrderBy _

derive instance newtypeFollowsOrderBy :: Newtype FollowsOrderBy _

instance toGraphQLArgumentValueFollowsOrderBy :: ToGraphQLArgumentValue
                                                 FollowsOrderBy where
  toGraphQLArgumentValue (FollowsOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_pk_columns_input
newtype FollowsPkColumnsInput = FollowsPkColumnsInput { id :: Int }

derive instance genericFollowsPkColumnsInput :: Generic FollowsPkColumnsInput _

derive instance newtypeFollowsPkColumnsInput :: Newtype FollowsPkColumnsInput _

instance toGraphQLArgumentValueFollowsPkColumnsInput :: ToGraphQLArgumentValue
                                                        FollowsPkColumnsInput where
  toGraphQLArgumentValue (FollowsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - json_comparison_exp
newtype JsonComparisonExp = JsonComparisonExp { "_eq" :: Optional Json
                                              , "_gt" :: Optional Json
                                              , "_gte" :: Optional Json
                                              , "_in" :: Optional (Array Json)
                                              , "_is_null" :: Optional Boolean
                                              , "_lt" :: Optional Json
                                              , "_lte" :: Optional Json
                                              , "_neq" :: Optional Json
                                              , "_nin" :: Optional (Array Json)
                                              }

derive instance genericJsonComparisonExp :: Generic JsonComparisonExp _

derive instance newtypeJsonComparisonExp :: Newtype JsonComparisonExp _

instance toGraphQLArgumentValueJsonComparisonExp :: ToGraphQLArgumentValue
                                                    JsonComparisonExp where
  toGraphQLArgumentValue (JsonComparisonExp x) = toGraphQLArgumentValue x

-- | original name - likes_aggregate_order_by
newtype LikesAggregateOrderBy = LikesAggregateOrderBy { avg :: Optional
                                                               LikesAvgOrderBy
                                                      , count :: Optional
                                                                 OrderBy
                                                      , max :: Optional
                                                               LikesMaxOrderBy
                                                      , min :: Optional
                                                               LikesMinOrderBy
                                                      , stddev :: Optional
                                                                  LikesStddevOrderBy
                                                      , stddev_pop :: Optional
                                                                      LikesStddevPopOrderBy
                                                      , stddev_samp :: Optional
                                                                       LikesStddevSampOrderBy
                                                      , sum :: Optional
                                                               LikesSumOrderBy
                                                      , var_pop :: Optional
                                                                   LikesVarPopOrderBy
                                                      , var_samp :: Optional
                                                                    LikesVarSampOrderBy
                                                      , variance :: Optional
                                                                    LikesVarianceOrderBy
                                                      }

derive instance genericLikesAggregateOrderBy :: Generic LikesAggregateOrderBy _

derive instance newtypeLikesAggregateOrderBy :: Newtype LikesAggregateOrderBy _

instance toGraphQLArgumentValueLikesAggregateOrderBy :: ToGraphQLArgumentValue
                                                        LikesAggregateOrderBy where
  toGraphQLArgumentValue (LikesAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_arr_rel_insert_input
newtype LikesArrRelInsertInput = LikesArrRelInsertInput { "data" :: Array
                                                                    LikesInsertInput
                                                        }

derive instance genericLikesArrRelInsertInput :: Generic LikesArrRelInsertInput _

derive instance newtypeLikesArrRelInsertInput :: Newtype LikesArrRelInsertInput _

instance toGraphQLArgumentValueLikesArrRelInsertInput :: ToGraphQLArgumentValue
                                                         LikesArrRelInsertInput where
  toGraphQLArgumentValue (LikesArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_avg_order_by
newtype LikesAvgOrderBy = LikesAvgOrderBy { article_id :: Optional OrderBy
                                          , user_id :: Optional OrderBy
                                          }

derive instance genericLikesAvgOrderBy :: Generic LikesAvgOrderBy _

derive instance newtypeLikesAvgOrderBy :: Newtype LikesAvgOrderBy _

instance toGraphQLArgumentValueLikesAvgOrderBy :: ToGraphQLArgumentValue
                                                  LikesAvgOrderBy where
  toGraphQLArgumentValue (LikesAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_bool_exp
newtype LikesBoolExp = LikesBoolExp { "_and" :: Optional
                                                (Array
                                                 (Maybe
                                                  LikesBoolExp))
                                    , "_not" :: Optional LikesBoolExp
                                    , "_or" :: Optional
                                               (Array
                                                (Maybe
                                                 LikesBoolExp))
                                    , article :: Optional ArticlesBoolExp
                                    , article_id :: Optional IntComparisonExp
                                    , user :: Optional UsersBoolExp
                                    , user_id :: Optional IntComparisonExp
                                    }

derive instance genericLikesBoolExp :: Generic LikesBoolExp _

derive instance newtypeLikesBoolExp :: Newtype LikesBoolExp _

instance toGraphQLArgumentValueLikesBoolExp :: ToGraphQLArgumentValue
                                               LikesBoolExp where
  toGraphQLArgumentValue (LikesBoolExp x) = toGraphQLArgumentValue x

-- | original name - likes_insert_input
newtype LikesInsertInput = LikesInsertInput { article :: Optional
                                                         ArticlesObjRelInsertInput
                                            , article_id :: Optional Int
                                            }

derive instance genericLikesInsertInput :: Generic LikesInsertInput _

derive instance newtypeLikesInsertInput :: Newtype LikesInsertInput _

instance toGraphQLArgumentValueLikesInsertInput :: ToGraphQLArgumentValue
                                                   LikesInsertInput where
  toGraphQLArgumentValue (LikesInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_max_order_by
newtype LikesMaxOrderBy = LikesMaxOrderBy { article_id :: Optional OrderBy
                                          , user_id :: Optional OrderBy
                                          }

derive instance genericLikesMaxOrderBy :: Generic LikesMaxOrderBy _

derive instance newtypeLikesMaxOrderBy :: Newtype LikesMaxOrderBy _

instance toGraphQLArgumentValueLikesMaxOrderBy :: ToGraphQLArgumentValue
                                                  LikesMaxOrderBy where
  toGraphQLArgumentValue (LikesMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_min_order_by
newtype LikesMinOrderBy = LikesMinOrderBy { article_id :: Optional OrderBy
                                          , user_id :: Optional OrderBy
                                          }

derive instance genericLikesMinOrderBy :: Generic LikesMinOrderBy _

derive instance newtypeLikesMinOrderBy :: Newtype LikesMinOrderBy _

instance toGraphQLArgumentValueLikesMinOrderBy :: ToGraphQLArgumentValue
                                                  LikesMinOrderBy where
  toGraphQLArgumentValue (LikesMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_obj_rel_insert_input
newtype LikesObjRelInsertInput = LikesObjRelInsertInput { "data" :: LikesInsertInput
                                                        }

derive instance genericLikesObjRelInsertInput :: Generic LikesObjRelInsertInput _

derive instance newtypeLikesObjRelInsertInput :: Newtype LikesObjRelInsertInput _

instance toGraphQLArgumentValueLikesObjRelInsertInput :: ToGraphQLArgumentValue
                                                         LikesObjRelInsertInput where
  toGraphQLArgumentValue (LikesObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_order_by
newtype LikesOrderBy = LikesOrderBy { article :: Optional ArticlesOrderBy
                                    , article_id :: Optional OrderBy
                                    , user :: Optional UsersOrderBy
                                    , user_id :: Optional OrderBy
                                    }

derive instance genericLikesOrderBy :: Generic LikesOrderBy _

derive instance newtypeLikesOrderBy :: Newtype LikesOrderBy _

instance toGraphQLArgumentValueLikesOrderBy :: ToGraphQLArgumentValue
                                               LikesOrderBy where
  toGraphQLArgumentValue (LikesOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_pk_columns_input
newtype LikesPkColumnsInput = LikesPkColumnsInput { id :: Int }

derive instance genericLikesPkColumnsInput :: Generic LikesPkColumnsInput _

derive instance newtypeLikesPkColumnsInput :: Newtype LikesPkColumnsInput _

instance toGraphQLArgumentValueLikesPkColumnsInput :: ToGraphQLArgumentValue
                                                      LikesPkColumnsInput where
  toGraphQLArgumentValue (LikesPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_order_by
newtype LikesStddevOrderBy = LikesStddevOrderBy { article_id :: Optional OrderBy
                                                , user_id :: Optional OrderBy
                                                }

derive instance genericLikesStddevOrderBy :: Generic LikesStddevOrderBy _

derive instance newtypeLikesStddevOrderBy :: Newtype LikesStddevOrderBy _

instance toGraphQLArgumentValueLikesStddevOrderBy :: ToGraphQLArgumentValue
                                                     LikesStddevOrderBy where
  toGraphQLArgumentValue (LikesStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_pop_order_by
newtype LikesStddevPopOrderBy = LikesStddevPopOrderBy { article_id :: Optional
                                                                      OrderBy
                                                      , user_id :: Optional
                                                                   OrderBy
                                                      }

derive instance genericLikesStddevPopOrderBy :: Generic LikesStddevPopOrderBy _

derive instance newtypeLikesStddevPopOrderBy :: Newtype LikesStddevPopOrderBy _

instance toGraphQLArgumentValueLikesStddevPopOrderBy :: ToGraphQLArgumentValue
                                                        LikesStddevPopOrderBy where
  toGraphQLArgumentValue (LikesStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_samp_order_by
newtype LikesStddevSampOrderBy = LikesStddevSampOrderBy { article_id :: Optional
                                                                        OrderBy
                                                        , user_id :: Optional
                                                                     OrderBy
                                                        }

derive instance genericLikesStddevSampOrderBy :: Generic LikesStddevSampOrderBy _

derive instance newtypeLikesStddevSampOrderBy :: Newtype LikesStddevSampOrderBy _

instance toGraphQLArgumentValueLikesStddevSampOrderBy :: ToGraphQLArgumentValue
                                                         LikesStddevSampOrderBy where
  toGraphQLArgumentValue (LikesStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_sum_order_by
newtype LikesSumOrderBy = LikesSumOrderBy { article_id :: Optional OrderBy
                                          , user_id :: Optional OrderBy
                                          }

derive instance genericLikesSumOrderBy :: Generic LikesSumOrderBy _

derive instance newtypeLikesSumOrderBy :: Newtype LikesSumOrderBy _

instance toGraphQLArgumentValueLikesSumOrderBy :: ToGraphQLArgumentValue
                                                  LikesSumOrderBy where
  toGraphQLArgumentValue (LikesSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_var_pop_order_by
newtype LikesVarPopOrderBy = LikesVarPopOrderBy { article_id :: Optional OrderBy
                                                , user_id :: Optional OrderBy
                                                }

derive instance genericLikesVarPopOrderBy :: Generic LikesVarPopOrderBy _

derive instance newtypeLikesVarPopOrderBy :: Newtype LikesVarPopOrderBy _

instance toGraphQLArgumentValueLikesVarPopOrderBy :: ToGraphQLArgumentValue
                                                     LikesVarPopOrderBy where
  toGraphQLArgumentValue (LikesVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_var_samp_order_by
newtype LikesVarSampOrderBy = LikesVarSampOrderBy { article_id :: Optional
                                                                  OrderBy
                                                  , user_id :: Optional OrderBy
                                                  }

derive instance genericLikesVarSampOrderBy :: Generic LikesVarSampOrderBy _

derive instance newtypeLikesVarSampOrderBy :: Newtype LikesVarSampOrderBy _

instance toGraphQLArgumentValueLikesVarSampOrderBy :: ToGraphQLArgumentValue
                                                      LikesVarSampOrderBy where
  toGraphQLArgumentValue (LikesVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_variance_order_by
newtype LikesVarianceOrderBy = LikesVarianceOrderBy { article_id :: Optional
                                                                    OrderBy
                                                    , user_id :: Optional
                                                                 OrderBy
                                                    }

derive instance genericLikesVarianceOrderBy :: Generic LikesVarianceOrderBy _

derive instance newtypeLikesVarianceOrderBy :: Newtype LikesVarianceOrderBy _

instance toGraphQLArgumentValueLikesVarianceOrderBy :: ToGraphQLArgumentValue
                                                       LikesVarianceOrderBy where
  toGraphQLArgumentValue (LikesVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_bool_exp
newtype ProfileBoolExp = ProfileBoolExp { "_and" :: Optional
                                                    (Array
                                                     (Maybe
                                                      ProfileBoolExp))
                                        , "_not" :: Optional ProfileBoolExp
                                        , "_or" :: Optional
                                                   (Array
                                                    (Maybe
                                                     ProfileBoolExp))
                                        , bio :: Optional StringComparisonExp
                                        , email :: Optional StringComparisonExp
                                        , follows :: Optional FollowsBoolExp
                                        , profile_image :: Optional
                                                           StringComparisonExp
                                        , user_id :: Optional IntComparisonExp
                                        , username :: Optional
                                                      StringComparisonExp
                                        }

derive instance genericProfileBoolExp :: Generic ProfileBoolExp _

derive instance newtypeProfileBoolExp :: Newtype ProfileBoolExp _

instance toGraphQLArgumentValueProfileBoolExp :: ToGraphQLArgumentValue
                                                 ProfileBoolExp where
  toGraphQLArgumentValue (ProfileBoolExp x) = toGraphQLArgumentValue x

-- | original name - profile_order_by
newtype ProfileOrderBy = ProfileOrderBy { bio :: Optional OrderBy
                                        , email :: Optional OrderBy
                                        , profile_image :: Optional OrderBy
                                        , user_id :: Optional OrderBy
                                        , username :: Optional OrderBy
                                        }

derive instance genericProfileOrderBy :: Generic ProfileOrderBy _

derive instance newtypeProfileOrderBy :: Newtype ProfileOrderBy _

instance toGraphQLArgumentValueProfileOrderBy :: ToGraphQLArgumentValue
                                                 ProfileOrderBy where
  toGraphQLArgumentValue (ProfileOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_arr_rel_insert_input
newtype TagsArrRelInsertInput = TagsArrRelInsertInput { "data" :: Array
                                                                  TagsInsertInput
                                                      }

derive instance genericTagsArrRelInsertInput :: Generic TagsArrRelInsertInput _

derive instance newtypeTagsArrRelInsertInput :: Newtype TagsArrRelInsertInput _

instance toGraphQLArgumentValueTagsArrRelInsertInput :: ToGraphQLArgumentValue
                                                        TagsArrRelInsertInput where
  toGraphQLArgumentValue (TagsArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_bool_exp
newtype TagsBoolExp = TagsBoolExp { "_and" :: Optional
                                              (Array
                                               (Maybe
                                                TagsBoolExp))
                                  , "_not" :: Optional TagsBoolExp
                                  , "_or" :: Optional
                                             (Array
                                              (Maybe
                                               TagsBoolExp))
                                  , article :: Optional ArticlesBoolExp
                                  , tag :: Optional StringComparisonExp
                                  }

derive instance genericTagsBoolExp :: Generic TagsBoolExp _

derive instance newtypeTagsBoolExp :: Newtype TagsBoolExp _

instance toGraphQLArgumentValueTagsBoolExp :: ToGraphQLArgumentValue TagsBoolExp where
  toGraphQLArgumentValue (TagsBoolExp x) = toGraphQLArgumentValue x

-- | original name - tags_insert_input
newtype TagsInsertInput = TagsInsertInput { article :: Optional
                                                       ArticlesObjRelInsertInput
                                          , article_id :: Optional Int
                                          , tag :: Optional String
                                          }

derive instance genericTagsInsertInput :: Generic TagsInsertInput _

derive instance newtypeTagsInsertInput :: Newtype TagsInsertInput _

instance toGraphQLArgumentValueTagsInsertInput :: ToGraphQLArgumentValue
                                                  TagsInsertInput where
  toGraphQLArgumentValue (TagsInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_obj_rel_insert_input
newtype TagsObjRelInsertInput = TagsObjRelInsertInput { "data" :: TagsInsertInput
                                                      }

derive instance genericTagsObjRelInsertInput :: Generic TagsObjRelInsertInput _

derive instance newtypeTagsObjRelInsertInput :: Newtype TagsObjRelInsertInput _

instance toGraphQLArgumentValueTagsObjRelInsertInput :: ToGraphQLArgumentValue
                                                        TagsObjRelInsertInput where
  toGraphQLArgumentValue (TagsObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_order_by
newtype TagsOrderBy = TagsOrderBy { article :: Optional ArticlesOrderBy
                                  , tag :: Optional OrderBy
                                  }

derive instance genericTagsOrderBy :: Generic TagsOrderBy _

derive instance newtypeTagsOrderBy :: Newtype TagsOrderBy _

instance toGraphQLArgumentValueTagsOrderBy :: ToGraphQLArgumentValue TagsOrderBy where
  toGraphQLArgumentValue (TagsOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_pk_columns_input
newtype TagsPkColumnsInput = TagsPkColumnsInput { id :: Int }

derive instance genericTagsPkColumnsInput :: Generic TagsPkColumnsInput _

derive instance newtypeTagsPkColumnsInput :: Newtype TagsPkColumnsInput _

instance toGraphQLArgumentValueTagsPkColumnsInput :: ToGraphQLArgumentValue
                                                     TagsPkColumnsInput where
  toGraphQLArgumentValue (TagsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - timestamptz_comparison_exp
newtype TimestamptzComparisonExp = TimestamptzComparisonExp { "_eq" :: Optional
                                                                       Timestamptz
                                                            , "_gt" :: Optional
                                                                       Timestamptz
                                                            , "_gte" :: Optional
                                                                        Timestamptz
                                                            , "_in" :: Optional
                                                                       (Array
                                                                        Timestamptz)
                                                            , "_is_null" :: Optional
                                                                            Boolean
                                                            , "_lt" :: Optional
                                                                       Timestamptz
                                                            , "_lte" :: Optional
                                                                        Timestamptz
                                                            , "_neq" :: Optional
                                                                        Timestamptz
                                                            , "_nin" :: Optional
                                                                        (Array
                                                                         Timestamptz)
                                                            }

derive instance genericTimestamptzComparisonExp :: Generic TimestamptzComparisonExp _

derive instance newtypeTimestamptzComparisonExp :: Newtype TimestamptzComparisonExp _

instance toGraphQLArgumentValueTimestamptzComparisonExp :: ToGraphQLArgumentValue
                                                           TimestamptzComparisonExp where
  toGraphQLArgumentValue (TimestamptzComparisonExp x) = toGraphQLArgumentValue x

-- | original name - users_bool_exp
newtype UsersBoolExp = UsersBoolExp { "_and" :: Optional
                                                (Array
                                                 (Maybe
                                                  UsersBoolExp))
                                    , "_not" :: Optional UsersBoolExp
                                    , "_or" :: Optional
                                               (Array
                                                (Maybe
                                                 UsersBoolExp))
                                    , articles :: Optional ArticlesBoolExp
                                    , follows :: Optional FollowsBoolExp
                                    , id :: Optional IntComparisonExp
                                    , profile_image :: Optional
                                                       StringComparisonExp
                                    , username :: Optional StringComparisonExp
                                    }

derive instance genericUsersBoolExp :: Generic UsersBoolExp _

derive instance newtypeUsersBoolExp :: Newtype UsersBoolExp _

instance toGraphQLArgumentValueUsersBoolExp :: ToGraphQLArgumentValue
                                               UsersBoolExp where
  toGraphQLArgumentValue (UsersBoolExp x) = toGraphQLArgumentValue x

-- | original name - users_on_conflict
newtype UsersOnConflict = UsersOnConflict { constraint :: UsersConstraint
                                          , update_columns :: Array
                                                              UsersUpdateColumn
                                          , "where" :: Optional UsersBoolExp
                                          }

derive instance genericUsersOnConflict :: Generic UsersOnConflict _

derive instance newtypeUsersOnConflict :: Newtype UsersOnConflict _

instance toGraphQLArgumentValueUsersOnConflict :: ToGraphQLArgumentValue
                                                  UsersOnConflict where
  toGraphQLArgumentValue (UsersOnConflict x) = toGraphQLArgumentValue x

-- | original name - users_order_by
newtype UsersOrderBy = UsersOrderBy { articles_aggregate :: Optional
                                                            ArticlesAggregateOrderBy
                                    , id :: Optional OrderBy
                                    , profile_image :: Optional OrderBy
                                    , username :: Optional OrderBy
                                    }

derive instance genericUsersOrderBy :: Generic UsersOrderBy _

derive instance newtypeUsersOrderBy :: Newtype UsersOrderBy _

instance toGraphQLArgumentValueUsersOrderBy :: ToGraphQLArgumentValue
                                               UsersOrderBy where
  toGraphQLArgumentValue (UsersOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_pk_columns_input
newtype UsersPkColumnsInput = UsersPkColumnsInput { id :: Int }

derive instance genericUsersPkColumnsInput :: Generic UsersPkColumnsInput _

derive instance newtypeUsersPkColumnsInput :: Newtype UsersPkColumnsInput _

instance toGraphQLArgumentValueUsersPkColumnsInput :: ToGraphQLArgumentValue
                                                      UsersPkColumnsInput where
  toGraphQLArgumentValue (UsersPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - users_set_input
newtype UsersSetInput = UsersSetInput { bio :: Optional String
                                      , email :: Optional String
                                      , profile_image :: Optional String
                                      , username :: Optional String
                                      }

derive instance genericUsersSetInput :: Generic UsersSetInput _

derive instance newtypeUsersSetInput :: Newtype UsersSetInput _

instance toGraphQLArgumentValueUsersSetInput :: ToGraphQLArgumentValue
                                                UsersSetInput where
  toGraphQLArgumentValue (UsersSetInput x) = toGraphQLArgumentValue x
