module Api.InputObject where

import Api.Enum.ArticlesConstraint (ArticlesConstraint)
import Api.Enum.ArticlesUpdateColumn (ArticlesUpdateColumn)
import Api.Enum.CommentsConstraint (CommentsConstraint)
import Api.Enum.CommentsUpdateColumn (CommentsUpdateColumn)
import Api.Enum.FollowsConstraint (FollowsConstraint)
import Api.Enum.FollowsUpdateColumn (FollowsUpdateColumn)
import Api.Enum.LikesConstraint (LikesConstraint)
import Api.Enum.LikesUpdateColumn (LikesUpdateColumn)
import Api.Enum.OrderBy (OrderBy)
import Api.Enum.TagsConstraint (TagsConstraint)
import Api.Enum.TagsUpdateColumn (TagsUpdateColumn)
import Api.Enum.UsersConstraint (UsersConstraint)
import Api.Enum.UsersUpdateColumn (UsersUpdateColumn)
import Api.Scalars (Timestamptz, Json)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import GraphQLClient (class DefaultInput, class ToGraphQLArgumentValue, Optional, defaultInput, toGraphQLArgumentValue)

-- | original name - Int_comparison_exp
newtype IntComparisonExp
  = IntComparisonExp IntComparisonExp_

type IntComparisonExp_
  = { "_eq" :: Optional Int
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

instance toGraphQLArgumentValueIntComparisonExp ::
  ToGraphQLArgumentValue
    IntComparisonExp where
  toGraphQLArgumentValue (IntComparisonExp x) = toGraphQLArgumentValue x

-- | original name - String_comparison_exp
newtype StringComparisonExp
  = StringComparisonExp StringComparisonExp_

type StringComparisonExp_
  = { "_eq" :: Optional String
    , "_gt" :: Optional String
    , "_gte" :: Optional String
    , "_ilike" :: Optional String
    , "_in" ::
        Optional
          ( Array
              String
          )
    , "_is_null" ::
        Optional
          Boolean
    , "_like" :: Optional String
    , "_lt" :: Optional String
    , "_lte" :: Optional String
    , "_neq" :: Optional String
    , "_nilike" :: Optional String
    , "_nin" ::
        Optional
          ( Array
              String
          )
    , "_nlike" :: Optional String
    , "_nsimilar" ::
        Optional
          String
    , "_similar" ::
        Optional
          String
    }

derive instance genericStringComparisonExp :: Generic StringComparisonExp _

derive instance newtypeStringComparisonExp :: Newtype StringComparisonExp _

instance toGraphQLArgumentValueStringComparisonExp ::
  ToGraphQLArgumentValue
    StringComparisonExp where
  toGraphQLArgumentValue (StringComparisonExp x) = toGraphQLArgumentValue x

-- | original name - articles_aggregate_order_by
newtype ArticlesAggregateOrderBy
  = ArticlesAggregateOrderBy
  { avg ::
      Optional
        ArticlesAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        ArticlesMaxOrderBy
  , min ::
      Optional
        ArticlesMinOrderBy
  , stddev ::
      Optional
        ArticlesStddevOrderBy
  , stddev_pop ::
      Optional
        ArticlesStddevPopOrderBy
  , stddev_samp ::
      Optional
        ArticlesStddevSampOrderBy
  , sum ::
      Optional
        ArticlesSumOrderBy
  , var_pop ::
      Optional
        ArticlesVarPopOrderBy
  , var_samp ::
      Optional
        ArticlesVarSampOrderBy
  , variance ::
      Optional
        ArticlesVarianceOrderBy
  }

derive instance genericArticlesAggregateOrderBy :: Generic ArticlesAggregateOrderBy _

derive instance newtypeArticlesAggregateOrderBy :: Newtype ArticlesAggregateOrderBy _

instance toGraphQLArgumentValueArticlesAggregateOrderBy ::
  ToGraphQLArgumentValue
    ArticlesAggregateOrderBy where
  toGraphQLArgumentValue (ArticlesAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_arr_rel_insert_input
newtype ArticlesArrRelInsertInput
  = ArticlesArrRelInsertInput
  { "data" ::
      Array
        ArticlesInsertInput
  , on_conflict ::
      Optional
        ArticlesOnConflict
  }

derive instance genericArticlesArrRelInsertInput :: Generic ArticlesArrRelInsertInput _

derive instance newtypeArticlesArrRelInsertInput :: Newtype ArticlesArrRelInsertInput _

instance toGraphQLArgumentValueArticlesArrRelInsertInput ::
  ToGraphQLArgumentValue
    ArticlesArrRelInsertInput where
  toGraphQLArgumentValue (ArticlesArrRelInsertInput x) =
    toGraphQLArgumentValue
      x

-- | original name - articles_avg_order_by
newtype ArticlesAvgOrderBy
  = ArticlesAvgOrderBy
  { author_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericArticlesAvgOrderBy :: Generic ArticlesAvgOrderBy _

derive instance newtypeArticlesAvgOrderBy :: Newtype ArticlesAvgOrderBy _

instance toGraphQLArgumentValueArticlesAvgOrderBy ::
  ToGraphQLArgumentValue
    ArticlesAvgOrderBy where
  toGraphQLArgumentValue (ArticlesAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_bool_exp
newtype ArticlesBoolExp
  = ArticlesBoolExp
  { "_and" ::
      Optional
        ( Array
            ( Maybe
                ArticlesBoolExp
            )
        )
  , "_not" :: Optional ArticlesBoolExp
  , "_or" ::
      Optional
        ( Array
            ( Maybe
                ArticlesBoolExp
            )
        )
  , about ::
      Optional
        StringComparisonExp
  , author :: Optional UsersBoolExp
  , author_id ::
      Optional
        IntComparisonExp
  , comments :: Optional CommentsBoolExp
  , content ::
      Optional
        StringComparisonExp
  , created_at ::
      Optional
        TimestamptzComparisonExp
  , id :: Optional IntComparisonExp
  , likes :: Optional LikesBoolExp
  , tags :: Optional TagsBoolExp
  , title ::
      Optional
        StringComparisonExp
  }

derive instance genericArticlesBoolExp :: Generic ArticlesBoolExp _

derive instance newtypeArticlesBoolExp :: Newtype ArticlesBoolExp _

instance toGraphQLArgumentValueArticlesBoolExp ::
  ToGraphQLArgumentValue
    ArticlesBoolExp where
  toGraphQLArgumentValue (ArticlesBoolExp x) = toGraphQLArgumentValue x

-- | original name - articles_inc_input
newtype ArticlesIncInput
  = ArticlesIncInput
  { author_id :: Optional Int
  , id :: Optional Int
  }

derive instance genericArticlesIncInput :: Generic ArticlesIncInput _

derive instance newtypeArticlesIncInput :: Newtype ArticlesIncInput _

instance toGraphQLArgumentValueArticlesIncInput ::
  ToGraphQLArgumentValue
    ArticlesIncInput where
  toGraphQLArgumentValue (ArticlesIncInput x) = toGraphQLArgumentValue x

-- | original name - articles_insert_input
newtype ArticlesInsertInput
  = ArticlesInsertInput
  { about :: Optional String
  , author ::
      Optional
        UsersObjRelInsertInput
  , author_id :: Optional Int
  , comments ::
      Optional
        CommentsArrRelInsertInput
  , content :: Optional String
  , created_at ::
      Optional
        Timestamptz
  , id :: Optional Int
  , likes ::
      Optional
        LikesArrRelInsertInput
  , tags ::
      Optional
        TagsArrRelInsertInput
  , title :: Optional String
  }

derive instance genericArticlesInsertInput :: Generic ArticlesInsertInput _

derive instance newtypeArticlesInsertInput :: Newtype ArticlesInsertInput _

instance toGraphQLArgumentValueArticlesInsertInput ::
  ToGraphQLArgumentValue
    ArticlesInsertInput where
  toGraphQLArgumentValue (ArticlesInsertInput x) = toGraphQLArgumentValue x

-- | original name - articles_max_order_by
newtype ArticlesMaxOrderBy
  = ArticlesMaxOrderBy
  { about :: Optional OrderBy
  , author_id :: Optional OrderBy
  , content :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , title :: Optional OrderBy
  }

derive instance genericArticlesMaxOrderBy :: Generic ArticlesMaxOrderBy _

derive instance newtypeArticlesMaxOrderBy :: Newtype ArticlesMaxOrderBy _

instance toGraphQLArgumentValueArticlesMaxOrderBy ::
  ToGraphQLArgumentValue
    ArticlesMaxOrderBy where
  toGraphQLArgumentValue (ArticlesMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_min_order_by
newtype ArticlesMinOrderBy
  = ArticlesMinOrderBy
  { about :: Optional OrderBy
  , author_id :: Optional OrderBy
  , content :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , title :: Optional OrderBy
  }

derive instance genericArticlesMinOrderBy :: Generic ArticlesMinOrderBy _

derive instance newtypeArticlesMinOrderBy :: Newtype ArticlesMinOrderBy _

instance toGraphQLArgumentValueArticlesMinOrderBy ::
  ToGraphQLArgumentValue
    ArticlesMinOrderBy where
  toGraphQLArgumentValue (ArticlesMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_obj_rel_insert_input
newtype ArticlesObjRelInsertInput
  = ArticlesObjRelInsertInput
  { "data" :: ArticlesInsertInput
  , on_conflict ::
      Optional
        ArticlesOnConflict
  }

derive instance genericArticlesObjRelInsertInput :: Generic ArticlesObjRelInsertInput _

derive instance newtypeArticlesObjRelInsertInput :: Newtype ArticlesObjRelInsertInput _

instance toGraphQLArgumentValueArticlesObjRelInsertInput ::
  ToGraphQLArgumentValue
    ArticlesObjRelInsertInput where
  toGraphQLArgumentValue (ArticlesObjRelInsertInput x) =
    toGraphQLArgumentValue
      x

-- | original name - articles_on_conflict
newtype ArticlesOnConflict
  = ArticlesOnConflict
  { constraint :: ArticlesConstraint
  , update_columns ::
      Array
        ArticlesUpdateColumn
  , "where" ::
      Optional
        ArticlesBoolExp
  }

derive instance genericArticlesOnConflict :: Generic ArticlesOnConflict _

derive instance newtypeArticlesOnConflict :: Newtype ArticlesOnConflict _

instance toGraphQLArgumentValueArticlesOnConflict ::
  ToGraphQLArgumentValue
    ArticlesOnConflict where
  toGraphQLArgumentValue (ArticlesOnConflict x) = toGraphQLArgumentValue x

-- | original name - articles_order_by
newtype ArticlesOrderBy
  = ArticlesOrderBy
  { about :: Optional OrderBy
  , author :: Optional UsersOrderBy
  , author_id :: Optional OrderBy
  , comments_aggregate ::
      Optional
        CommentsAggregateOrderBy
  , content :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , likes_aggregate ::
      Optional
        LikesAggregateOrderBy
  , tags_aggregate ::
      Optional
        TagsAggregateOrderBy
  , title :: Optional OrderBy
  }

derive instance genericArticlesOrderBy :: Generic ArticlesOrderBy _

derive instance newtypeArticlesOrderBy :: Newtype ArticlesOrderBy _

instance toGraphQLArgumentValueArticlesOrderBy ::
  ToGraphQLArgumentValue
    ArticlesOrderBy where
  toGraphQLArgumentValue (ArticlesOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_pk_columns_input
newtype ArticlesPkColumnsInput
  = ArticlesPkColumnsInput { id :: Int }

derive instance genericArticlesPkColumnsInput :: Generic ArticlesPkColumnsInput _

derive instance newtypeArticlesPkColumnsInput :: Newtype ArticlesPkColumnsInput _

instance toGraphQLArgumentValueArticlesPkColumnsInput ::
  ToGraphQLArgumentValue
    ArticlesPkColumnsInput where
  toGraphQLArgumentValue (ArticlesPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - articles_set_input
newtype ArticlesSetInput
  = ArticlesSetInput
  { about :: Optional String
  , author_id :: Optional Int
  , content :: Optional String
  , created_at :: Optional Timestamptz
  , id :: Optional Int
  , title :: Optional String
  }

derive instance genericArticlesSetInput :: Generic ArticlesSetInput _

derive instance newtypeArticlesSetInput :: Newtype ArticlesSetInput _

instance toGraphQLArgumentValueArticlesSetInput ::
  ToGraphQLArgumentValue
    ArticlesSetInput where
  toGraphQLArgumentValue (ArticlesSetInput x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_order_by
newtype ArticlesStddevOrderBy
  = ArticlesStddevOrderBy
  { author_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericArticlesStddevOrderBy :: Generic ArticlesStddevOrderBy _

derive instance newtypeArticlesStddevOrderBy :: Newtype ArticlesStddevOrderBy _

instance toGraphQLArgumentValueArticlesStddevOrderBy ::
  ToGraphQLArgumentValue
    ArticlesStddevOrderBy where
  toGraphQLArgumentValue (ArticlesStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_pop_order_by
newtype ArticlesStddevPopOrderBy
  = ArticlesStddevPopOrderBy
  { author_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  }

derive instance genericArticlesStddevPopOrderBy :: Generic ArticlesStddevPopOrderBy _

derive instance newtypeArticlesStddevPopOrderBy :: Newtype ArticlesStddevPopOrderBy _

instance toGraphQLArgumentValueArticlesStddevPopOrderBy ::
  ToGraphQLArgumentValue
    ArticlesStddevPopOrderBy where
  toGraphQLArgumentValue (ArticlesStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_stddev_samp_order_by
newtype ArticlesStddevSampOrderBy
  = ArticlesStddevSampOrderBy
  { author_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  }

derive instance genericArticlesStddevSampOrderBy :: Generic ArticlesStddevSampOrderBy _

derive instance newtypeArticlesStddevSampOrderBy :: Newtype ArticlesStddevSampOrderBy _

instance toGraphQLArgumentValueArticlesStddevSampOrderBy ::
  ToGraphQLArgumentValue
    ArticlesStddevSampOrderBy where
  toGraphQLArgumentValue (ArticlesStddevSampOrderBy x) =
    toGraphQLArgumentValue
      x

-- | original name - articles_sum_order_by
newtype ArticlesSumOrderBy
  = ArticlesSumOrderBy
  { author_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericArticlesSumOrderBy :: Generic ArticlesSumOrderBy _

derive instance newtypeArticlesSumOrderBy :: Newtype ArticlesSumOrderBy _

instance toGraphQLArgumentValueArticlesSumOrderBy ::
  ToGraphQLArgumentValue
    ArticlesSumOrderBy where
  toGraphQLArgumentValue (ArticlesSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_var_pop_order_by
newtype ArticlesVarPopOrderBy
  = ArticlesVarPopOrderBy
  { author_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericArticlesVarPopOrderBy :: Generic ArticlesVarPopOrderBy _

derive instance newtypeArticlesVarPopOrderBy :: Newtype ArticlesVarPopOrderBy _

instance toGraphQLArgumentValueArticlesVarPopOrderBy ::
  ToGraphQLArgumentValue
    ArticlesVarPopOrderBy where
  toGraphQLArgumentValue (ArticlesVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_var_samp_order_by
newtype ArticlesVarSampOrderBy
  = ArticlesVarSampOrderBy
  { author_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericArticlesVarSampOrderBy :: Generic ArticlesVarSampOrderBy _

derive instance newtypeArticlesVarSampOrderBy :: Newtype ArticlesVarSampOrderBy _

instance toGraphQLArgumentValueArticlesVarSampOrderBy ::
  ToGraphQLArgumentValue
    ArticlesVarSampOrderBy where
  toGraphQLArgumentValue (ArticlesVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - articles_variance_order_by
newtype ArticlesVarianceOrderBy
  = ArticlesVarianceOrderBy
  { author_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  }

derive instance genericArticlesVarianceOrderBy :: Generic ArticlesVarianceOrderBy _

derive instance newtypeArticlesVarianceOrderBy :: Newtype ArticlesVarianceOrderBy _

instance toGraphQLArgumentValueArticlesVarianceOrderBy ::
  ToGraphQLArgumentValue
    ArticlesVarianceOrderBy where
  toGraphQLArgumentValue (ArticlesVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_aggregate_order_by
newtype CommentsAggregateOrderBy
  = CommentsAggregateOrderBy
  { avg ::
      Optional
        CommentsAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        CommentsMaxOrderBy
  , min ::
      Optional
        CommentsMinOrderBy
  , stddev ::
      Optional
        CommentsStddevOrderBy
  , stddev_pop ::
      Optional
        CommentsStddevPopOrderBy
  , stddev_samp ::
      Optional
        CommentsStddevSampOrderBy
  , sum ::
      Optional
        CommentsSumOrderBy
  , var_pop ::
      Optional
        CommentsVarPopOrderBy
  , var_samp ::
      Optional
        CommentsVarSampOrderBy
  , variance ::
      Optional
        CommentsVarianceOrderBy
  }

derive instance genericCommentsAggregateOrderBy :: Generic CommentsAggregateOrderBy _

derive instance newtypeCommentsAggregateOrderBy :: Newtype CommentsAggregateOrderBy _

instance toGraphQLArgumentValueCommentsAggregateOrderBy ::
  ToGraphQLArgumentValue
    CommentsAggregateOrderBy where
  toGraphQLArgumentValue (CommentsAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_arr_rel_insert_input
newtype CommentsArrRelInsertInput
  = CommentsArrRelInsertInput
  { "data" ::
      Array
        CommentsInsertInput
  , on_conflict ::
      Optional
        CommentsOnConflict
  }

derive instance genericCommentsArrRelInsertInput :: Generic CommentsArrRelInsertInput _

derive instance newtypeCommentsArrRelInsertInput :: Newtype CommentsArrRelInsertInput _

instance toGraphQLArgumentValueCommentsArrRelInsertInput ::
  ToGraphQLArgumentValue
    CommentsArrRelInsertInput where
  toGraphQLArgumentValue (CommentsArrRelInsertInput x) =
    toGraphQLArgumentValue
      x

-- | original name - comments_avg_order_by
newtype CommentsAvgOrderBy
  = CommentsAvgOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericCommentsAvgOrderBy :: Generic CommentsAvgOrderBy _

derive instance newtypeCommentsAvgOrderBy :: Newtype CommentsAvgOrderBy _

instance toGraphQLArgumentValueCommentsAvgOrderBy ::
  ToGraphQLArgumentValue
    CommentsAvgOrderBy where
  toGraphQLArgumentValue (CommentsAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_bool_exp
newtype CommentsBoolExp
  = CommentsBoolExp
  { "_and" ::
      Optional
        ( Array
            ( Maybe
                CommentsBoolExp
            )
        )
  , "_not" :: Optional CommentsBoolExp
  , "_or" ::
      Optional
        ( Array
            ( Maybe
                CommentsBoolExp
            )
        )
  , article :: Optional ArticlesBoolExp
  , article_id ::
      Optional
        IntComparisonExp
  , comment ::
      Optional
        StringComparisonExp
  , created_at ::
      Optional
        TimestamptzComparisonExp
  , id :: Optional IntComparisonExp
  , user :: Optional UsersBoolExp
  , user_id :: Optional IntComparisonExp
  }

derive instance genericCommentsBoolExp :: Generic CommentsBoolExp _

derive instance newtypeCommentsBoolExp :: Newtype CommentsBoolExp _

instance toGraphQLArgumentValueCommentsBoolExp ::
  ToGraphQLArgumentValue
    CommentsBoolExp where
  toGraphQLArgumentValue (CommentsBoolExp x) = toGraphQLArgumentValue x

-- | original name - comments_inc_input
newtype CommentsIncInput
  = CommentsIncInput
  { article_id :: Optional Int
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericCommentsIncInput :: Generic CommentsIncInput _

derive instance newtypeCommentsIncInput :: Newtype CommentsIncInput _

instance toGraphQLArgumentValueCommentsIncInput ::
  ToGraphQLArgumentValue
    CommentsIncInput where
  toGraphQLArgumentValue (CommentsIncInput x) = toGraphQLArgumentValue x

-- | original name - comments_insert_input
newtype CommentsInsertInput
  = CommentsInsertInput
  { article ::
      Optional
        ArticlesObjRelInsertInput
  , article_id :: Optional Int
  , comment :: Optional String
  , created_at ::
      Optional
        Timestamptz
  , id :: Optional Int
  , user ::
      Optional
        UsersObjRelInsertInput
  , user_id :: Optional Int
  }

derive instance genericCommentsInsertInput :: Generic CommentsInsertInput _

derive instance newtypeCommentsInsertInput :: Newtype CommentsInsertInput _

instance toGraphQLArgumentValueCommentsInsertInput ::
  ToGraphQLArgumentValue
    CommentsInsertInput where
  toGraphQLArgumentValue (CommentsInsertInput x) = toGraphQLArgumentValue x

-- | original name - comments_max_order_by
newtype CommentsMaxOrderBy
  = CommentsMaxOrderBy
  { article_id :: Optional OrderBy
  , comment :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericCommentsMaxOrderBy :: Generic CommentsMaxOrderBy _

derive instance newtypeCommentsMaxOrderBy :: Newtype CommentsMaxOrderBy _

instance toGraphQLArgumentValueCommentsMaxOrderBy ::
  ToGraphQLArgumentValue
    CommentsMaxOrderBy where
  toGraphQLArgumentValue (CommentsMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_min_order_by
newtype CommentsMinOrderBy
  = CommentsMinOrderBy
  { article_id :: Optional OrderBy
  , comment :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericCommentsMinOrderBy :: Generic CommentsMinOrderBy _

derive instance newtypeCommentsMinOrderBy :: Newtype CommentsMinOrderBy _

instance toGraphQLArgumentValueCommentsMinOrderBy ::
  ToGraphQLArgumentValue
    CommentsMinOrderBy where
  toGraphQLArgumentValue (CommentsMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_obj_rel_insert_input
newtype CommentsObjRelInsertInput
  = CommentsObjRelInsertInput
  { "data" :: CommentsInsertInput
  , on_conflict ::
      Optional
        CommentsOnConflict
  }

derive instance genericCommentsObjRelInsertInput :: Generic CommentsObjRelInsertInput _

derive instance newtypeCommentsObjRelInsertInput :: Newtype CommentsObjRelInsertInput _

instance toGraphQLArgumentValueCommentsObjRelInsertInput ::
  ToGraphQLArgumentValue
    CommentsObjRelInsertInput where
  toGraphQLArgumentValue (CommentsObjRelInsertInput x) =
    toGraphQLArgumentValue
      x

-- | original name - comments_on_conflict
newtype CommentsOnConflict
  = CommentsOnConflict
  { constraint :: CommentsConstraint
  , update_columns ::
      Array
        CommentsUpdateColumn
  , "where" ::
      Optional
        CommentsBoolExp
  }

derive instance genericCommentsOnConflict :: Generic CommentsOnConflict _

derive instance newtypeCommentsOnConflict :: Newtype CommentsOnConflict _

instance toGraphQLArgumentValueCommentsOnConflict ::
  ToGraphQLArgumentValue
    CommentsOnConflict where
  toGraphQLArgumentValue (CommentsOnConflict x) = toGraphQLArgumentValue x

-- | original name - comments_order_by
newtype CommentsOrderBy
  = CommentsOrderBy
  { article :: Optional ArticlesOrderBy
  , article_id :: Optional OrderBy
  , comment :: Optional OrderBy
  , created_at :: Optional OrderBy
  , id :: Optional OrderBy
  , user :: Optional UsersOrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericCommentsOrderBy :: Generic CommentsOrderBy _

derive instance newtypeCommentsOrderBy :: Newtype CommentsOrderBy _

instance toGraphQLArgumentValueCommentsOrderBy ::
  ToGraphQLArgumentValue
    CommentsOrderBy where
  toGraphQLArgumentValue (CommentsOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_pk_columns_input
newtype CommentsPkColumnsInput
  = CommentsPkColumnsInput { id :: Int }

derive instance genericCommentsPkColumnsInput :: Generic CommentsPkColumnsInput _

derive instance newtypeCommentsPkColumnsInput :: Newtype CommentsPkColumnsInput _

instance toGraphQLArgumentValueCommentsPkColumnsInput ::
  ToGraphQLArgumentValue
    CommentsPkColumnsInput where
  toGraphQLArgumentValue (CommentsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - comments_set_input
newtype CommentsSetInput
  = CommentsSetInput
  { article_id :: Optional Int
  , comment :: Optional String
  , created_at :: Optional Timestamptz
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericCommentsSetInput :: Generic CommentsSetInput _

derive instance newtypeCommentsSetInput :: Newtype CommentsSetInput _

instance toGraphQLArgumentValueCommentsSetInput ::
  ToGraphQLArgumentValue
    CommentsSetInput where
  toGraphQLArgumentValue (CommentsSetInput x) = toGraphQLArgumentValue x

-- | original name - comments_stddev_order_by
newtype CommentsStddevOrderBy
  = CommentsStddevOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsStddevOrderBy :: Generic CommentsStddevOrderBy _

derive instance newtypeCommentsStddevOrderBy :: Newtype CommentsStddevOrderBy _

instance toGraphQLArgumentValueCommentsStddevOrderBy ::
  ToGraphQLArgumentValue
    CommentsStddevOrderBy where
  toGraphQLArgumentValue (CommentsStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_stddev_pop_order_by
newtype CommentsStddevPopOrderBy
  = CommentsStddevPopOrderBy
  { article_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsStddevPopOrderBy :: Generic CommentsStddevPopOrderBy _

derive instance newtypeCommentsStddevPopOrderBy :: Newtype CommentsStddevPopOrderBy _

instance toGraphQLArgumentValueCommentsStddevPopOrderBy ::
  ToGraphQLArgumentValue
    CommentsStddevPopOrderBy where
  toGraphQLArgumentValue (CommentsStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_stddev_samp_order_by
newtype CommentsStddevSampOrderBy
  = CommentsStddevSampOrderBy
  { article_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsStddevSampOrderBy :: Generic CommentsStddevSampOrderBy _

derive instance newtypeCommentsStddevSampOrderBy :: Newtype CommentsStddevSampOrderBy _

instance toGraphQLArgumentValueCommentsStddevSampOrderBy ::
  ToGraphQLArgumentValue
    CommentsStddevSampOrderBy where
  toGraphQLArgumentValue (CommentsStddevSampOrderBy x) =
    toGraphQLArgumentValue
      x

-- | original name - comments_sum_order_by
newtype CommentsSumOrderBy
  = CommentsSumOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericCommentsSumOrderBy :: Generic CommentsSumOrderBy _

derive instance newtypeCommentsSumOrderBy :: Newtype CommentsSumOrderBy _

instance toGraphQLArgumentValueCommentsSumOrderBy ::
  ToGraphQLArgumentValue
    CommentsSumOrderBy where
  toGraphQLArgumentValue (CommentsSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_var_pop_order_by
newtype CommentsVarPopOrderBy
  = CommentsVarPopOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsVarPopOrderBy :: Generic CommentsVarPopOrderBy _

derive instance newtypeCommentsVarPopOrderBy :: Newtype CommentsVarPopOrderBy _

instance toGraphQLArgumentValueCommentsVarPopOrderBy ::
  ToGraphQLArgumentValue
    CommentsVarPopOrderBy where
  toGraphQLArgumentValue (CommentsVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_var_samp_order_by
newtype CommentsVarSampOrderBy
  = CommentsVarSampOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsVarSampOrderBy :: Generic CommentsVarSampOrderBy _

derive instance newtypeCommentsVarSampOrderBy :: Newtype CommentsVarSampOrderBy _

instance toGraphQLArgumentValueCommentsVarSampOrderBy ::
  ToGraphQLArgumentValue
    CommentsVarSampOrderBy where
  toGraphQLArgumentValue (CommentsVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - comments_variance_order_by
newtype CommentsVarianceOrderBy
  = CommentsVarianceOrderBy
  { article_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericCommentsVarianceOrderBy :: Generic CommentsVarianceOrderBy _

derive instance newtypeCommentsVarianceOrderBy :: Newtype CommentsVarianceOrderBy _

instance toGraphQLArgumentValueCommentsVarianceOrderBy ::
  ToGraphQLArgumentValue
    CommentsVarianceOrderBy where
  toGraphQLArgumentValue (CommentsVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_aggregate_order_by
newtype FollowsAggregateOrderBy
  = FollowsAggregateOrderBy
  { avg ::
      Optional
        FollowsAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        FollowsMaxOrderBy
  , min ::
      Optional
        FollowsMinOrderBy
  , stddev ::
      Optional
        FollowsStddevOrderBy
  , stddev_pop ::
      Optional
        FollowsStddevPopOrderBy
  , stddev_samp ::
      Optional
        FollowsStddevSampOrderBy
  , sum ::
      Optional
        FollowsSumOrderBy
  , var_pop ::
      Optional
        FollowsVarPopOrderBy
  , var_samp ::
      Optional
        FollowsVarSampOrderBy
  , variance ::
      Optional
        FollowsVarianceOrderBy
  }

derive instance genericFollowsAggregateOrderBy :: Generic FollowsAggregateOrderBy _

derive instance newtypeFollowsAggregateOrderBy :: Newtype FollowsAggregateOrderBy _

instance toGraphQLArgumentValueFollowsAggregateOrderBy ::
  ToGraphQLArgumentValue
    FollowsAggregateOrderBy where
  toGraphQLArgumentValue (FollowsAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_arr_rel_insert_input
newtype FollowsArrRelInsertInput
  = FollowsArrRelInsertInput
  { "data" ::
      Array
        FollowsInsertInput
  , on_conflict ::
      Optional
        FollowsOnConflict
  }

derive instance genericFollowsArrRelInsertInput :: Generic FollowsArrRelInsertInput _

derive instance newtypeFollowsArrRelInsertInput :: Newtype FollowsArrRelInsertInput _

instance toGraphQLArgumentValueFollowsArrRelInsertInput ::
  ToGraphQLArgumentValue
    FollowsArrRelInsertInput where
  toGraphQLArgumentValue (FollowsArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_avg_order_by
newtype FollowsAvgOrderBy
  = FollowsAvgOrderBy
  { following_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericFollowsAvgOrderBy :: Generic FollowsAvgOrderBy _

derive instance newtypeFollowsAvgOrderBy :: Newtype FollowsAvgOrderBy _

instance toGraphQLArgumentValueFollowsAvgOrderBy ::
  ToGraphQLArgumentValue
    FollowsAvgOrderBy where
  toGraphQLArgumentValue (FollowsAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_bool_exp
newtype FollowsBoolExp
  = FollowsBoolExp
  { "_and" ::
      Optional
        ( Array
            ( Maybe
                FollowsBoolExp
            )
        )
  , "_not" :: Optional FollowsBoolExp
  , "_or" ::
      Optional
        ( Array
            ( Maybe
                FollowsBoolExp
            )
        )
  , following_id ::
      Optional
        IntComparisonExp
  , id :: Optional IntComparisonExp
  , user :: Optional UsersBoolExp
  , user_id :: Optional IntComparisonExp
  }

derive instance genericFollowsBoolExp :: Generic FollowsBoolExp _

derive instance newtypeFollowsBoolExp :: Newtype FollowsBoolExp _

instance toGraphQLArgumentValueFollowsBoolExp ::
  ToGraphQLArgumentValue
    FollowsBoolExp where
  toGraphQLArgumentValue (FollowsBoolExp x) = toGraphQLArgumentValue x

-- | original name - follows_inc_input
newtype FollowsIncInput
  = FollowsIncInput
  { following_id :: Optional Int
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericFollowsIncInput :: Generic FollowsIncInput _

derive instance newtypeFollowsIncInput :: Newtype FollowsIncInput _

instance toGraphQLArgumentValueFollowsIncInput ::
  ToGraphQLArgumentValue
    FollowsIncInput where
  toGraphQLArgumentValue (FollowsIncInput x) = toGraphQLArgumentValue x

-- | original name - follows_insert_input
newtype FollowsInsertInput
  = FollowsInsertInput
  { following_id :: Optional Int
  , id :: Optional Int
  , user ::
      Optional
        UsersObjRelInsertInput
  , user_id :: Optional Int
  }

derive instance genericFollowsInsertInput :: Generic FollowsInsertInput _

derive instance newtypeFollowsInsertInput :: Newtype FollowsInsertInput _

instance toGraphQLArgumentValueFollowsInsertInput ::
  ToGraphQLArgumentValue
    FollowsInsertInput where
  toGraphQLArgumentValue (FollowsInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_max_order_by
newtype FollowsMaxOrderBy
  = FollowsMaxOrderBy
  { following_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericFollowsMaxOrderBy :: Generic FollowsMaxOrderBy _

derive instance newtypeFollowsMaxOrderBy :: Newtype FollowsMaxOrderBy _

instance toGraphQLArgumentValueFollowsMaxOrderBy ::
  ToGraphQLArgumentValue
    FollowsMaxOrderBy where
  toGraphQLArgumentValue (FollowsMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_min_order_by
newtype FollowsMinOrderBy
  = FollowsMinOrderBy
  { following_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericFollowsMinOrderBy :: Generic FollowsMinOrderBy _

derive instance newtypeFollowsMinOrderBy :: Newtype FollowsMinOrderBy _

instance toGraphQLArgumentValueFollowsMinOrderBy ::
  ToGraphQLArgumentValue
    FollowsMinOrderBy where
  toGraphQLArgumentValue (FollowsMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_obj_rel_insert_input
newtype FollowsObjRelInsertInput
  = FollowsObjRelInsertInput
  { "data" :: FollowsInsertInput
  , on_conflict ::
      Optional
        FollowsOnConflict
  }

derive instance genericFollowsObjRelInsertInput :: Generic FollowsObjRelInsertInput _

derive instance newtypeFollowsObjRelInsertInput :: Newtype FollowsObjRelInsertInput _

instance toGraphQLArgumentValueFollowsObjRelInsertInput ::
  ToGraphQLArgumentValue
    FollowsObjRelInsertInput where
  toGraphQLArgumentValue (FollowsObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - follows_on_conflict
newtype FollowsOnConflict
  = FollowsOnConflict
  { constraint :: FollowsConstraint
  , update_columns ::
      Array
        FollowsUpdateColumn
  , "where" ::
      Optional
        FollowsBoolExp
  }

derive instance genericFollowsOnConflict :: Generic FollowsOnConflict _

derive instance newtypeFollowsOnConflict :: Newtype FollowsOnConflict _

instance toGraphQLArgumentValueFollowsOnConflict ::
  ToGraphQLArgumentValue
    FollowsOnConflict where
  toGraphQLArgumentValue (FollowsOnConflict x) = toGraphQLArgumentValue x

-- | original name - follows_order_by
newtype FollowsOrderBy
  = FollowsOrderBy
  { following_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user :: Optional UsersOrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericFollowsOrderBy :: Generic FollowsOrderBy _

derive instance newtypeFollowsOrderBy :: Newtype FollowsOrderBy _

instance toGraphQLArgumentValueFollowsOrderBy ::
  ToGraphQLArgumentValue
    FollowsOrderBy where
  toGraphQLArgumentValue (FollowsOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_pk_columns_input
newtype FollowsPkColumnsInput
  = FollowsPkColumnsInput { id :: Int }

derive instance genericFollowsPkColumnsInput :: Generic FollowsPkColumnsInput _

derive instance newtypeFollowsPkColumnsInput :: Newtype FollowsPkColumnsInput _

instance toGraphQLArgumentValueFollowsPkColumnsInput ::
  ToGraphQLArgumentValue
    FollowsPkColumnsInput where
  toGraphQLArgumentValue (FollowsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - follows_set_input
newtype FollowsSetInput
  = FollowsSetInput
  { following_id :: Optional Int
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericFollowsSetInput :: Generic FollowsSetInput _

derive instance newtypeFollowsSetInput :: Newtype FollowsSetInput _

instance toGraphQLArgumentValueFollowsSetInput ::
  ToGraphQLArgumentValue
    FollowsSetInput where
  toGraphQLArgumentValue (FollowsSetInput x) = toGraphQLArgumentValue x

-- | original name - follows_stddev_order_by
newtype FollowsStddevOrderBy
  = FollowsStddevOrderBy
  { following_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsStddevOrderBy :: Generic FollowsStddevOrderBy _

derive instance newtypeFollowsStddevOrderBy :: Newtype FollowsStddevOrderBy _

instance toGraphQLArgumentValueFollowsStddevOrderBy ::
  ToGraphQLArgumentValue
    FollowsStddevOrderBy where
  toGraphQLArgumentValue (FollowsStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_stddev_pop_order_by
newtype FollowsStddevPopOrderBy
  = FollowsStddevPopOrderBy
  { following_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsStddevPopOrderBy :: Generic FollowsStddevPopOrderBy _

derive instance newtypeFollowsStddevPopOrderBy :: Newtype FollowsStddevPopOrderBy _

instance toGraphQLArgumentValueFollowsStddevPopOrderBy ::
  ToGraphQLArgumentValue
    FollowsStddevPopOrderBy where
  toGraphQLArgumentValue (FollowsStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_stddev_samp_order_by
newtype FollowsStddevSampOrderBy
  = FollowsStddevSampOrderBy
  { following_id ::
      Optional
        OrderBy
  , id ::
      Optional
        OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsStddevSampOrderBy :: Generic FollowsStddevSampOrderBy _

derive instance newtypeFollowsStddevSampOrderBy :: Newtype FollowsStddevSampOrderBy _

instance toGraphQLArgumentValueFollowsStddevSampOrderBy ::
  ToGraphQLArgumentValue
    FollowsStddevSampOrderBy where
  toGraphQLArgumentValue (FollowsStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_sum_order_by
newtype FollowsSumOrderBy
  = FollowsSumOrderBy
  { following_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericFollowsSumOrderBy :: Generic FollowsSumOrderBy _

derive instance newtypeFollowsSumOrderBy :: Newtype FollowsSumOrderBy _

instance toGraphQLArgumentValueFollowsSumOrderBy ::
  ToGraphQLArgumentValue
    FollowsSumOrderBy where
  toGraphQLArgumentValue (FollowsSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_var_pop_order_by
newtype FollowsVarPopOrderBy
  = FollowsVarPopOrderBy
  { following_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsVarPopOrderBy :: Generic FollowsVarPopOrderBy _

derive instance newtypeFollowsVarPopOrderBy :: Newtype FollowsVarPopOrderBy _

instance toGraphQLArgumentValueFollowsVarPopOrderBy ::
  ToGraphQLArgumentValue
    FollowsVarPopOrderBy where
  toGraphQLArgumentValue (FollowsVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_var_samp_order_by
newtype FollowsVarSampOrderBy
  = FollowsVarSampOrderBy
  { following_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsVarSampOrderBy :: Generic FollowsVarSampOrderBy _

derive instance newtypeFollowsVarSampOrderBy :: Newtype FollowsVarSampOrderBy _

instance toGraphQLArgumentValueFollowsVarSampOrderBy ::
  ToGraphQLArgumentValue
    FollowsVarSampOrderBy where
  toGraphQLArgumentValue (FollowsVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - follows_variance_order_by
newtype FollowsVarianceOrderBy
  = FollowsVarianceOrderBy
  { following_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericFollowsVarianceOrderBy :: Generic FollowsVarianceOrderBy _

derive instance newtypeFollowsVarianceOrderBy :: Newtype FollowsVarianceOrderBy _

instance toGraphQLArgumentValueFollowsVarianceOrderBy ::
  ToGraphQLArgumentValue
    FollowsVarianceOrderBy where
  toGraphQLArgumentValue (FollowsVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - json_comparison_exp
newtype JsonComparisonExp
  = JsonComparisonExp
  { "_eq" :: Optional Json
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

instance toGraphQLArgumentValueJsonComparisonExp ::
  ToGraphQLArgumentValue
    JsonComparisonExp where
  toGraphQLArgumentValue (JsonComparisonExp x) = toGraphQLArgumentValue x

-- | original name - likes_aggregate_order_by
newtype LikesAggregateOrderBy
  = LikesAggregateOrderBy
  { avg ::
      Optional
        LikesAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        LikesMaxOrderBy
  , min ::
      Optional
        LikesMinOrderBy
  , stddev ::
      Optional
        LikesStddevOrderBy
  , stddev_pop ::
      Optional
        LikesStddevPopOrderBy
  , stddev_samp ::
      Optional
        LikesStddevSampOrderBy
  , sum ::
      Optional
        LikesSumOrderBy
  , var_pop ::
      Optional
        LikesVarPopOrderBy
  , var_samp ::
      Optional
        LikesVarSampOrderBy
  , variance ::
      Optional
        LikesVarianceOrderBy
  }

derive instance genericLikesAggregateOrderBy :: Generic LikesAggregateOrderBy _

derive instance newtypeLikesAggregateOrderBy :: Newtype LikesAggregateOrderBy _

instance toGraphQLArgumentValueLikesAggregateOrderBy ::
  ToGraphQLArgumentValue
    LikesAggregateOrderBy where
  toGraphQLArgumentValue (LikesAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_arr_rel_insert_input
newtype LikesArrRelInsertInput
  = LikesArrRelInsertInput
  { "data" ::
      Array
        LikesInsertInput
  , on_conflict ::
      Optional
        LikesOnConflict
  }

derive instance genericLikesArrRelInsertInput :: Generic LikesArrRelInsertInput _

derive instance newtypeLikesArrRelInsertInput :: Newtype LikesArrRelInsertInput _

instance toGraphQLArgumentValueLikesArrRelInsertInput ::
  ToGraphQLArgumentValue
    LikesArrRelInsertInput where
  toGraphQLArgumentValue (LikesArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_avg_order_by
newtype LikesAvgOrderBy
  = LikesAvgOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesAvgOrderBy :: Generic LikesAvgOrderBy _

derive instance newtypeLikesAvgOrderBy :: Newtype LikesAvgOrderBy _

instance toGraphQLArgumentValueLikesAvgOrderBy ::
  ToGraphQLArgumentValue
    LikesAvgOrderBy where
  toGraphQLArgumentValue (LikesAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_bool_exp
newtype LikesBoolExp
  = LikesBoolExp LikesBoolExp_

type LikesBoolExp_
  = { "_and" ::
        Optional
          ( Array
              ( Maybe
                  LikesBoolExp
              )
          )
    , "_not" :: Optional LikesBoolExp
    , "_or" ::
        Optional
          ( Array
              ( Maybe
                  LikesBoolExp
              )
          )
    , article :: Optional ArticlesBoolExp
    , article_id :: Optional IntComparisonExp
    , id :: Optional IntComparisonExp
    , user :: Optional UsersBoolExp
    , user_id :: Optional IntComparisonExp
    }

derive instance genericLikesBoolExp :: Generic LikesBoolExp _

derive instance newtypeLikesBoolExp :: Newtype LikesBoolExp _

instance toGraphQLArgumentValueLikesBoolExp ::
  ToGraphQLArgumentValue
    LikesBoolExp where
  toGraphQLArgumentValue (LikesBoolExp x) = toGraphQLArgumentValue x

-- | original name - likes_inc_input
newtype LikesIncInput
  = LikesIncInput
  { article_id :: Optional Int
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericLikesIncInput :: Generic LikesIncInput _

derive instance newtypeLikesIncInput :: Newtype LikesIncInput _

instance toGraphQLArgumentValueLikesIncInput ::
  ToGraphQLArgumentValue
    LikesIncInput where
  toGraphQLArgumentValue (LikesIncInput x) = toGraphQLArgumentValue x

-- | original name - likes_insert_input
newtype LikesInsertInput
  = LikesInsertInput
  { article ::
      Optional
        ArticlesObjRelInsertInput
  , article_id :: Optional Int
  , id :: Optional Int
  , user ::
      Optional
        UsersObjRelInsertInput
  , user_id :: Optional Int
  }

derive instance genericLikesInsertInput :: Generic LikesInsertInput _

derive instance newtypeLikesInsertInput :: Newtype LikesInsertInput _

instance toGraphQLArgumentValueLikesInsertInput ::
  ToGraphQLArgumentValue
    LikesInsertInput where
  toGraphQLArgumentValue (LikesInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_max_order_by
newtype LikesMaxOrderBy
  = LikesMaxOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesMaxOrderBy :: Generic LikesMaxOrderBy _

derive instance newtypeLikesMaxOrderBy :: Newtype LikesMaxOrderBy _

instance toGraphQLArgumentValueLikesMaxOrderBy ::
  ToGraphQLArgumentValue
    LikesMaxOrderBy where
  toGraphQLArgumentValue (LikesMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_min_order_by
newtype LikesMinOrderBy
  = LikesMinOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesMinOrderBy :: Generic LikesMinOrderBy _

derive instance newtypeLikesMinOrderBy :: Newtype LikesMinOrderBy _

instance toGraphQLArgumentValueLikesMinOrderBy ::
  ToGraphQLArgumentValue
    LikesMinOrderBy where
  toGraphQLArgumentValue (LikesMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_obj_rel_insert_input
newtype LikesObjRelInsertInput
  = LikesObjRelInsertInput
  { "data" :: LikesInsertInput
  , on_conflict ::
      Optional
        LikesOnConflict
  }

derive instance genericLikesObjRelInsertInput :: Generic LikesObjRelInsertInput _

derive instance newtypeLikesObjRelInsertInput :: Newtype LikesObjRelInsertInput _

instance toGraphQLArgumentValueLikesObjRelInsertInput ::
  ToGraphQLArgumentValue
    LikesObjRelInsertInput where
  toGraphQLArgumentValue (LikesObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - likes_on_conflict
newtype LikesOnConflict
  = LikesOnConflict
  { constraint :: LikesConstraint
  , update_columns ::
      Array
        LikesUpdateColumn
  , "where" :: Optional LikesBoolExp
  }

derive instance genericLikesOnConflict :: Generic LikesOnConflict _

derive instance newtypeLikesOnConflict :: Newtype LikesOnConflict _

instance toGraphQLArgumentValueLikesOnConflict ::
  ToGraphQLArgumentValue
    LikesOnConflict where
  toGraphQLArgumentValue (LikesOnConflict x) = toGraphQLArgumentValue x

-- | original name - likes_order_by
newtype LikesOrderBy
  = LikesOrderBy
  { article :: Optional ArticlesOrderBy
  , article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user :: Optional UsersOrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesOrderBy :: Generic LikesOrderBy _

derive instance newtypeLikesOrderBy :: Newtype LikesOrderBy _

instance toGraphQLArgumentValueLikesOrderBy ::
  ToGraphQLArgumentValue
    LikesOrderBy where
  toGraphQLArgumentValue (LikesOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_pk_columns_input
newtype LikesPkColumnsInput
  = LikesPkColumnsInput { id :: Int }

derive instance genericLikesPkColumnsInput :: Generic LikesPkColumnsInput _

derive instance newtypeLikesPkColumnsInput :: Newtype LikesPkColumnsInput _

instance toGraphQLArgumentValueLikesPkColumnsInput ::
  ToGraphQLArgumentValue
    LikesPkColumnsInput where
  toGraphQLArgumentValue (LikesPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - likes_set_input
newtype LikesSetInput
  = LikesSetInput
  { article_id :: Optional Int
  , id :: Optional Int
  , user_id :: Optional Int
  }

derive instance genericLikesSetInput :: Generic LikesSetInput _

derive instance newtypeLikesSetInput :: Newtype LikesSetInput _

instance toGraphQLArgumentValueLikesSetInput ::
  ToGraphQLArgumentValue
    LikesSetInput where
  toGraphQLArgumentValue (LikesSetInput x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_order_by
newtype LikesStddevOrderBy
  = LikesStddevOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesStddevOrderBy :: Generic LikesStddevOrderBy _

derive instance newtypeLikesStddevOrderBy :: Newtype LikesStddevOrderBy _

instance toGraphQLArgumentValueLikesStddevOrderBy ::
  ToGraphQLArgumentValue
    LikesStddevOrderBy where
  toGraphQLArgumentValue (LikesStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_pop_order_by
newtype LikesStddevPopOrderBy
  = LikesStddevPopOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericLikesStddevPopOrderBy :: Generic LikesStddevPopOrderBy _

derive instance newtypeLikesStddevPopOrderBy :: Newtype LikesStddevPopOrderBy _

instance toGraphQLArgumentValueLikesStddevPopOrderBy ::
  ToGraphQLArgumentValue
    LikesStddevPopOrderBy where
  toGraphQLArgumentValue (LikesStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_stddev_samp_order_by
newtype LikesStddevSampOrderBy
  = LikesStddevSampOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericLikesStddevSampOrderBy :: Generic LikesStddevSampOrderBy _

derive instance newtypeLikesStddevSampOrderBy :: Newtype LikesStddevSampOrderBy _

instance toGraphQLArgumentValueLikesStddevSampOrderBy ::
  ToGraphQLArgumentValue
    LikesStddevSampOrderBy where
  toGraphQLArgumentValue (LikesStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_sum_order_by
newtype LikesSumOrderBy
  = LikesSumOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesSumOrderBy :: Generic LikesSumOrderBy _

derive instance newtypeLikesSumOrderBy :: Newtype LikesSumOrderBy _

instance toGraphQLArgumentValueLikesSumOrderBy ::
  ToGraphQLArgumentValue
    LikesSumOrderBy where
  toGraphQLArgumentValue (LikesSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_var_pop_order_by
newtype LikesVarPopOrderBy
  = LikesVarPopOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesVarPopOrderBy :: Generic LikesVarPopOrderBy _

derive instance newtypeLikesVarPopOrderBy :: Newtype LikesVarPopOrderBy _

instance toGraphQLArgumentValueLikesVarPopOrderBy ::
  ToGraphQLArgumentValue
    LikesVarPopOrderBy where
  toGraphQLArgumentValue (LikesVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_var_samp_order_by
newtype LikesVarSampOrderBy
  = LikesVarSampOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id :: Optional OrderBy
  }

derive instance genericLikesVarSampOrderBy :: Generic LikesVarSampOrderBy _

derive instance newtypeLikesVarSampOrderBy :: Newtype LikesVarSampOrderBy _

instance toGraphQLArgumentValueLikesVarSampOrderBy ::
  ToGraphQLArgumentValue
    LikesVarSampOrderBy where
  toGraphQLArgumentValue (LikesVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - likes_variance_order_by
newtype LikesVarianceOrderBy
  = LikesVarianceOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  , user_id ::
      Optional
        OrderBy
  }

derive instance genericLikesVarianceOrderBy :: Generic LikesVarianceOrderBy _

derive instance newtypeLikesVarianceOrderBy :: Newtype LikesVarianceOrderBy _

instance toGraphQLArgumentValueLikesVarianceOrderBy ::
  ToGraphQLArgumentValue
    LikesVarianceOrderBy where
  toGraphQLArgumentValue (LikesVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_aggregate_order_by
newtype ProfileAggregateOrderBy
  = ProfileAggregateOrderBy
  { avg ::
      Optional
        ProfileAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        ProfileMaxOrderBy
  , min ::
      Optional
        ProfileMinOrderBy
  , stddev ::
      Optional
        ProfileStddevOrderBy
  , stddev_pop ::
      Optional
        ProfileStddevPopOrderBy
  , stddev_samp ::
      Optional
        ProfileStddevSampOrderBy
  , sum ::
      Optional
        ProfileSumOrderBy
  , var_pop ::
      Optional
        ProfileVarPopOrderBy
  , var_samp ::
      Optional
        ProfileVarSampOrderBy
  , variance ::
      Optional
        ProfileVarianceOrderBy
  }

derive instance genericProfileAggregateOrderBy :: Generic ProfileAggregateOrderBy _

derive instance newtypeProfileAggregateOrderBy :: Newtype ProfileAggregateOrderBy _

instance toGraphQLArgumentValueProfileAggregateOrderBy ::
  ToGraphQLArgumentValue
    ProfileAggregateOrderBy where
  toGraphQLArgumentValue (ProfileAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_arr_rel_insert_input
newtype ProfileArrRelInsertInput
  = ProfileArrRelInsertInput
  { "data" ::
      Array
        ProfileInsertInput
  }

derive instance genericProfileArrRelInsertInput :: Generic ProfileArrRelInsertInput _

derive instance newtypeProfileArrRelInsertInput :: Newtype ProfileArrRelInsertInput _

instance toGraphQLArgumentValueProfileArrRelInsertInput ::
  ToGraphQLArgumentValue
    ProfileArrRelInsertInput where
  toGraphQLArgumentValue (ProfileArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - profile_avg_order_by
newtype ProfileAvgOrderBy
  = ProfileAvgOrderBy { user_id :: Optional OrderBy }

derive instance genericProfileAvgOrderBy :: Generic ProfileAvgOrderBy _

derive instance newtypeProfileAvgOrderBy :: Newtype ProfileAvgOrderBy _

instance toGraphQLArgumentValueProfileAvgOrderBy ::
  ToGraphQLArgumentValue
    ProfileAvgOrderBy where
  toGraphQLArgumentValue (ProfileAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_bool_exp
newtype ProfileBoolExp
  = ProfileBoolExp
  { "_and" ::
      Optional
        ( Array
            ( Maybe
                ProfileBoolExp
            )
        )
  , "_not" :: Optional ProfileBoolExp
  , "_or" ::
      Optional
        ( Array
            ( Maybe
                ProfileBoolExp
            )
        )
  , bio :: Optional StringComparisonExp
  , email :: Optional StringComparisonExp
  , follows :: Optional FollowsBoolExp
  , profile_image ::
      Optional
        StringComparisonExp
  , user_id :: Optional IntComparisonExp
  , username ::
      Optional
        StringComparisonExp
  }

derive instance genericProfileBoolExp :: Generic ProfileBoolExp _

derive instance newtypeProfileBoolExp :: Newtype ProfileBoolExp _

instance toGraphQLArgumentValueProfileBoolExp ::
  ToGraphQLArgumentValue
    ProfileBoolExp where
  toGraphQLArgumentValue (ProfileBoolExp x) = toGraphQLArgumentValue x

-- | original name - profile_inc_input
newtype ProfileIncInput
  = ProfileIncInput { user_id :: Optional Int }

derive instance genericProfileIncInput :: Generic ProfileIncInput _

derive instance newtypeProfileIncInput :: Newtype ProfileIncInput _

instance toGraphQLArgumentValueProfileIncInput ::
  ToGraphQLArgumentValue
    ProfileIncInput where
  toGraphQLArgumentValue (ProfileIncInput x) = toGraphQLArgumentValue x

-- | original name - profile_insert_input
newtype ProfileInsertInput
  = ProfileInsertInput
  { bio :: Optional String
  , email :: Optional String
  , follows ::
      Optional
        FollowsArrRelInsertInput
  , profile_image ::
      Optional
        String
  , user_id :: Optional Int
  , username :: Optional String
  }

derive instance genericProfileInsertInput :: Generic ProfileInsertInput _

derive instance newtypeProfileInsertInput :: Newtype ProfileInsertInput _

instance toGraphQLArgumentValueProfileInsertInput ::
  ToGraphQLArgumentValue
    ProfileInsertInput where
  toGraphQLArgumentValue (ProfileInsertInput x) = toGraphQLArgumentValue x

-- | original name - profile_max_order_by
newtype ProfileMaxOrderBy
  = ProfileMaxOrderBy
  { bio :: Optional OrderBy
  , email :: Optional OrderBy
  , profile_image ::
      Optional
        OrderBy
  , user_id :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericProfileMaxOrderBy :: Generic ProfileMaxOrderBy _

derive instance newtypeProfileMaxOrderBy :: Newtype ProfileMaxOrderBy _

instance toGraphQLArgumentValueProfileMaxOrderBy ::
  ToGraphQLArgumentValue
    ProfileMaxOrderBy where
  toGraphQLArgumentValue (ProfileMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_min_order_by
newtype ProfileMinOrderBy
  = ProfileMinOrderBy
  { bio :: Optional OrderBy
  , email :: Optional OrderBy
  , profile_image ::
      Optional
        OrderBy
  , user_id :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericProfileMinOrderBy :: Generic ProfileMinOrderBy _

derive instance newtypeProfileMinOrderBy :: Newtype ProfileMinOrderBy _

instance toGraphQLArgumentValueProfileMinOrderBy ::
  ToGraphQLArgumentValue
    ProfileMinOrderBy where
  toGraphQLArgumentValue (ProfileMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_obj_rel_insert_input
newtype ProfileObjRelInsertInput
  = ProfileObjRelInsertInput
  { "data" :: ProfileInsertInput
  }

derive instance genericProfileObjRelInsertInput :: Generic ProfileObjRelInsertInput _

derive instance newtypeProfileObjRelInsertInput :: Newtype ProfileObjRelInsertInput _

instance toGraphQLArgumentValueProfileObjRelInsertInput ::
  ToGraphQLArgumentValue
    ProfileObjRelInsertInput where
  toGraphQLArgumentValue (ProfileObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - profile_order_by
newtype ProfileOrderBy
  = ProfileOrderBy
  { bio :: Optional OrderBy
  , email :: Optional OrderBy
  , follows_aggregate ::
      Optional
        FollowsAggregateOrderBy
  , profile_image :: Optional OrderBy
  , user_id :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericProfileOrderBy :: Generic ProfileOrderBy _

derive instance newtypeProfileOrderBy :: Newtype ProfileOrderBy _

instance toGraphQLArgumentValueProfileOrderBy ::
  ToGraphQLArgumentValue
    ProfileOrderBy where
  toGraphQLArgumentValue (ProfileOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_set_input
newtype ProfileSetInput
  = ProfileSetInput
  { bio :: Optional String
  , email :: Optional String
  , profile_image :: Optional String
  , user_id :: Optional Int
  , username :: Optional String
  }

derive instance genericProfileSetInput :: Generic ProfileSetInput _

derive instance newtypeProfileSetInput :: Newtype ProfileSetInput _

instance toGraphQLArgumentValueProfileSetInput ::
  ToGraphQLArgumentValue
    ProfileSetInput where
  toGraphQLArgumentValue (ProfileSetInput x) = toGraphQLArgumentValue x

-- | original name - profile_stddev_order_by
newtype ProfileStddevOrderBy
  = ProfileStddevOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileStddevOrderBy :: Generic ProfileStddevOrderBy _

derive instance newtypeProfileStddevOrderBy :: Newtype ProfileStddevOrderBy _

instance toGraphQLArgumentValueProfileStddevOrderBy ::
  ToGraphQLArgumentValue
    ProfileStddevOrderBy where
  toGraphQLArgumentValue (ProfileStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_stddev_pop_order_by
newtype ProfileStddevPopOrderBy
  = ProfileStddevPopOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileStddevPopOrderBy :: Generic ProfileStddevPopOrderBy _

derive instance newtypeProfileStddevPopOrderBy :: Newtype ProfileStddevPopOrderBy _

instance toGraphQLArgumentValueProfileStddevPopOrderBy ::
  ToGraphQLArgumentValue
    ProfileStddevPopOrderBy where
  toGraphQLArgumentValue (ProfileStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_stddev_samp_order_by
newtype ProfileStddevSampOrderBy
  = ProfileStddevSampOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileStddevSampOrderBy :: Generic ProfileStddevSampOrderBy _

derive instance newtypeProfileStddevSampOrderBy :: Newtype ProfileStddevSampOrderBy _

instance toGraphQLArgumentValueProfileStddevSampOrderBy ::
  ToGraphQLArgumentValue
    ProfileStddevSampOrderBy where
  toGraphQLArgumentValue (ProfileStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_sum_order_by
newtype ProfileSumOrderBy
  = ProfileSumOrderBy { user_id :: Optional OrderBy }

derive instance genericProfileSumOrderBy :: Generic ProfileSumOrderBy _

derive instance newtypeProfileSumOrderBy :: Newtype ProfileSumOrderBy _

instance toGraphQLArgumentValueProfileSumOrderBy ::
  ToGraphQLArgumentValue
    ProfileSumOrderBy where
  toGraphQLArgumentValue (ProfileSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_var_pop_order_by
newtype ProfileVarPopOrderBy
  = ProfileVarPopOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileVarPopOrderBy :: Generic ProfileVarPopOrderBy _

derive instance newtypeProfileVarPopOrderBy :: Newtype ProfileVarPopOrderBy _

instance toGraphQLArgumentValueProfileVarPopOrderBy ::
  ToGraphQLArgumentValue
    ProfileVarPopOrderBy where
  toGraphQLArgumentValue (ProfileVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_var_samp_order_by
newtype ProfileVarSampOrderBy
  = ProfileVarSampOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileVarSampOrderBy :: Generic ProfileVarSampOrderBy _

derive instance newtypeProfileVarSampOrderBy :: Newtype ProfileVarSampOrderBy _

instance toGraphQLArgumentValueProfileVarSampOrderBy ::
  ToGraphQLArgumentValue
    ProfileVarSampOrderBy where
  toGraphQLArgumentValue (ProfileVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - profile_variance_order_by
newtype ProfileVarianceOrderBy
  = ProfileVarianceOrderBy
  { user_id ::
      Optional
        OrderBy
  }

derive instance genericProfileVarianceOrderBy :: Generic ProfileVarianceOrderBy _

derive instance newtypeProfileVarianceOrderBy :: Newtype ProfileVarianceOrderBy _

instance toGraphQLArgumentValueProfileVarianceOrderBy ::
  ToGraphQLArgumentValue
    ProfileVarianceOrderBy where
  toGraphQLArgumentValue (ProfileVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_aggregate_order_by
newtype TagsAggregateOrderBy
  = TagsAggregateOrderBy
  { avg ::
      Optional
        TagsAvgOrderBy
  , count :: Optional OrderBy
  , max ::
      Optional
        TagsMaxOrderBy
  , min ::
      Optional
        TagsMinOrderBy
  , stddev ::
      Optional
        TagsStddevOrderBy
  , stddev_pop ::
      Optional
        TagsStddevPopOrderBy
  , stddev_samp ::
      Optional
        TagsStddevSampOrderBy
  , sum ::
      Optional
        TagsSumOrderBy
  , var_pop ::
      Optional
        TagsVarPopOrderBy
  , var_samp ::
      Optional
        TagsVarSampOrderBy
  , variance ::
      Optional
        TagsVarianceOrderBy
  }

derive instance genericTagsAggregateOrderBy :: Generic TagsAggregateOrderBy _

derive instance newtypeTagsAggregateOrderBy :: Newtype TagsAggregateOrderBy _

instance toGraphQLArgumentValueTagsAggregateOrderBy ::
  ToGraphQLArgumentValue
    TagsAggregateOrderBy where
  toGraphQLArgumentValue (TagsAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_arr_rel_insert_input
newtype TagsArrRelInsertInput
  = TagsArrRelInsertInput
  { "data" ::
      Array
        TagsInsertInput
  , on_conflict ::
      Optional
        TagsOnConflict
  }

derive instance genericTagsArrRelInsertInput :: Generic TagsArrRelInsertInput _

derive instance newtypeTagsArrRelInsertInput :: Newtype TagsArrRelInsertInput _

instance toGraphQLArgumentValueTagsArrRelInsertInput ::
  ToGraphQLArgumentValue
    TagsArrRelInsertInput where
  toGraphQLArgumentValue (TagsArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_avg_order_by
newtype TagsAvgOrderBy
  = TagsAvgOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsAvgOrderBy :: Generic TagsAvgOrderBy _

derive instance newtypeTagsAvgOrderBy :: Newtype TagsAvgOrderBy _

instance toGraphQLArgumentValueTagsAvgOrderBy ::
  ToGraphQLArgumentValue
    TagsAvgOrderBy where
  toGraphQLArgumentValue (TagsAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_bool_exp
newtype TagsBoolExp
  = TagsBoolExp
  { "_and" ::
      Optional
        ( Array
            ( Maybe
                TagsBoolExp
            )
        )
  , "_not" :: Optional TagsBoolExp
  , "_or" ::
      Optional
        ( Array
            ( Maybe
                TagsBoolExp
            )
        )
  , article :: Optional ArticlesBoolExp
  , article_id :: Optional IntComparisonExp
  , id :: Optional IntComparisonExp
  , tag :: Optional StringComparisonExp
  }

derive instance genericTagsBoolExp :: Generic TagsBoolExp _

derive instance newtypeTagsBoolExp :: Newtype TagsBoolExp _

instance toGraphQLArgumentValueTagsBoolExp :: ToGraphQLArgumentValue TagsBoolExp where
  toGraphQLArgumentValue (TagsBoolExp x) = toGraphQLArgumentValue x

-- | original name - tags_inc_input
newtype TagsIncInput
  = TagsIncInput
  { article_id :: Optional Int
  , id :: Optional Int
  }

derive instance genericTagsIncInput :: Generic TagsIncInput _

derive instance newtypeTagsIncInput :: Newtype TagsIncInput _

instance toGraphQLArgumentValueTagsIncInput ::
  ToGraphQLArgumentValue
    TagsIncInput where
  toGraphQLArgumentValue (TagsIncInput x) = toGraphQLArgumentValue x

-- | original name - tags_insert_input
newtype TagsInsertInput
  = TagsInsertInput
  { article ::
      Optional
        ArticlesObjRelInsertInput
  , article_id :: Optional Int
  , id :: Optional Int
  , tag :: Optional String
  }

derive instance genericTagsInsertInput :: Generic TagsInsertInput _

derive instance newtypeTagsInsertInput :: Newtype TagsInsertInput _

instance toGraphQLArgumentValueTagsInsertInput ::
  ToGraphQLArgumentValue
    TagsInsertInput where
  toGraphQLArgumentValue (TagsInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_max_order_by
newtype TagsMaxOrderBy
  = TagsMaxOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , tag :: Optional OrderBy
  }

derive instance genericTagsMaxOrderBy :: Generic TagsMaxOrderBy _

derive instance newtypeTagsMaxOrderBy :: Newtype TagsMaxOrderBy _

instance toGraphQLArgumentValueTagsMaxOrderBy ::
  ToGraphQLArgumentValue
    TagsMaxOrderBy where
  toGraphQLArgumentValue (TagsMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_min_order_by
newtype TagsMinOrderBy
  = TagsMinOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , tag :: Optional OrderBy
  }

derive instance genericTagsMinOrderBy :: Generic TagsMinOrderBy _

derive instance newtypeTagsMinOrderBy :: Newtype TagsMinOrderBy _

instance toGraphQLArgumentValueTagsMinOrderBy ::
  ToGraphQLArgumentValue
    TagsMinOrderBy where
  toGraphQLArgumentValue (TagsMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_obj_rel_insert_input
newtype TagsObjRelInsertInput
  = TagsObjRelInsertInput
  { "data" :: TagsInsertInput
  , on_conflict ::
      Optional
        TagsOnConflict
  }

derive instance genericTagsObjRelInsertInput :: Generic TagsObjRelInsertInput _

derive instance newtypeTagsObjRelInsertInput :: Newtype TagsObjRelInsertInput _

instance toGraphQLArgumentValueTagsObjRelInsertInput ::
  ToGraphQLArgumentValue
    TagsObjRelInsertInput where
  toGraphQLArgumentValue (TagsObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - tags_on_conflict
newtype TagsOnConflict
  = TagsOnConflict
  { constraint :: TagsConstraint
  , update_columns ::
      Array
        TagsUpdateColumn
  , "where" :: Optional TagsBoolExp
  }

derive instance genericTagsOnConflict :: Generic TagsOnConflict _

derive instance newtypeTagsOnConflict :: Newtype TagsOnConflict _

instance toGraphQLArgumentValueTagsOnConflict ::
  ToGraphQLArgumentValue
    TagsOnConflict where
  toGraphQLArgumentValue (TagsOnConflict x) = toGraphQLArgumentValue x

-- | original name - tags_order_by
newtype TagsOrderBy
  = TagsOrderBy
  { article :: Optional ArticlesOrderBy
  , article_id :: Optional OrderBy
  , id :: Optional OrderBy
  , tag :: Optional OrderBy
  }

derive instance genericTagsOrderBy :: Generic TagsOrderBy _

derive instance newtypeTagsOrderBy :: Newtype TagsOrderBy _

instance toGraphQLArgumentValueTagsOrderBy :: ToGraphQLArgumentValue TagsOrderBy where
  toGraphQLArgumentValue (TagsOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_pk_columns_input
newtype TagsPkColumnsInput
  = TagsPkColumnsInput { id :: Int }

derive instance genericTagsPkColumnsInput :: Generic TagsPkColumnsInput _

derive instance newtypeTagsPkColumnsInput :: Newtype TagsPkColumnsInput _

instance toGraphQLArgumentValueTagsPkColumnsInput ::
  ToGraphQLArgumentValue
    TagsPkColumnsInput where
  toGraphQLArgumentValue (TagsPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - tags_set_input
newtype TagsSetInput
  = TagsSetInput
  { article_id :: Optional Int
  , id :: Optional Int
  , tag :: Optional String
  }

derive instance genericTagsSetInput :: Generic TagsSetInput _

derive instance newtypeTagsSetInput :: Newtype TagsSetInput _

instance toGraphQLArgumentValueTagsSetInput ::
  ToGraphQLArgumentValue
    TagsSetInput where
  toGraphQLArgumentValue (TagsSetInput x) = toGraphQLArgumentValue x

-- | original name - tags_stddev_order_by
newtype TagsStddevOrderBy
  = TagsStddevOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsStddevOrderBy :: Generic TagsStddevOrderBy _

derive instance newtypeTagsStddevOrderBy :: Newtype TagsStddevOrderBy _

instance toGraphQLArgumentValueTagsStddevOrderBy ::
  ToGraphQLArgumentValue
    TagsStddevOrderBy where
  toGraphQLArgumentValue (TagsStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_stddev_pop_order_by
newtype TagsStddevPopOrderBy
  = TagsStddevPopOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsStddevPopOrderBy :: Generic TagsStddevPopOrderBy _

derive instance newtypeTagsStddevPopOrderBy :: Newtype TagsStddevPopOrderBy _

instance toGraphQLArgumentValueTagsStddevPopOrderBy ::
  ToGraphQLArgumentValue
    TagsStddevPopOrderBy where
  toGraphQLArgumentValue (TagsStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_stddev_samp_order_by
newtype TagsStddevSampOrderBy
  = TagsStddevSampOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsStddevSampOrderBy :: Generic TagsStddevSampOrderBy _

derive instance newtypeTagsStddevSampOrderBy :: Newtype TagsStddevSampOrderBy _

instance toGraphQLArgumentValueTagsStddevSampOrderBy ::
  ToGraphQLArgumentValue
    TagsStddevSampOrderBy where
  toGraphQLArgumentValue (TagsStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_sum_order_by
newtype TagsSumOrderBy
  = TagsSumOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsSumOrderBy :: Generic TagsSumOrderBy _

derive instance newtypeTagsSumOrderBy :: Newtype TagsSumOrderBy _

instance toGraphQLArgumentValueTagsSumOrderBy ::
  ToGraphQLArgumentValue
    TagsSumOrderBy where
  toGraphQLArgumentValue (TagsSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_var_pop_order_by
newtype TagsVarPopOrderBy
  = TagsVarPopOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsVarPopOrderBy :: Generic TagsVarPopOrderBy _

derive instance newtypeTagsVarPopOrderBy :: Newtype TagsVarPopOrderBy _

instance toGraphQLArgumentValueTagsVarPopOrderBy ::
  ToGraphQLArgumentValue
    TagsVarPopOrderBy where
  toGraphQLArgumentValue (TagsVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_var_samp_order_by
newtype TagsVarSampOrderBy
  = TagsVarSampOrderBy
  { article_id :: Optional OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsVarSampOrderBy :: Generic TagsVarSampOrderBy _

derive instance newtypeTagsVarSampOrderBy :: Newtype TagsVarSampOrderBy _

instance toGraphQLArgumentValueTagsVarSampOrderBy ::
  ToGraphQLArgumentValue
    TagsVarSampOrderBy where
  toGraphQLArgumentValue (TagsVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - tags_variance_order_by
newtype TagsVarianceOrderBy
  = TagsVarianceOrderBy
  { article_id ::
      Optional
        OrderBy
  , id :: Optional OrderBy
  }

derive instance genericTagsVarianceOrderBy :: Generic TagsVarianceOrderBy _

derive instance newtypeTagsVarianceOrderBy :: Newtype TagsVarianceOrderBy _

instance toGraphQLArgumentValueTagsVarianceOrderBy ::
  ToGraphQLArgumentValue
    TagsVarianceOrderBy where
  toGraphQLArgumentValue (TagsVarianceOrderBy x) = toGraphQLArgumentValue x

-- | original name - timestamptz_comparison_exp
newtype TimestamptzComparisonExp
  = TimestamptzComparisonExp
  { "_eq" ::
      Optional
        Timestamptz
  , "_gt" ::
      Optional
        Timestamptz
  , "_gte" ::
      Optional
        Timestamptz
  , "_in" ::
      Optional
        ( Array
            Timestamptz
        )
  , "_is_null" ::
      Optional
        Boolean
  , "_lt" ::
      Optional
        Timestamptz
  , "_lte" ::
      Optional
        Timestamptz
  , "_neq" ::
      Optional
        Timestamptz
  , "_nin" ::
      Optional
        ( Array
            Timestamptz
        )
  }

derive instance genericTimestamptzComparisonExp :: Generic TimestamptzComparisonExp _

derive instance newtypeTimestamptzComparisonExp :: Newtype TimestamptzComparisonExp _

instance toGraphQLArgumentValueTimestamptzComparisonExp ::
  ToGraphQLArgumentValue
    TimestamptzComparisonExp where
  toGraphQLArgumentValue (TimestamptzComparisonExp x) = toGraphQLArgumentValue x

-- | original name - users_aggregate_order_by
newtype UsersAggregateOrderBy
  = UsersAggregateOrderBy
  { avg ::
      Optional
        UsersAvgOrderBy
  , count ::
      Optional
        OrderBy
  , max ::
      Optional
        UsersMaxOrderBy
  , min ::
      Optional
        UsersMinOrderBy
  , stddev ::
      Optional
        UsersStddevOrderBy
  , stddev_pop ::
      Optional
        UsersStddevPopOrderBy
  , stddev_samp ::
      Optional
        UsersStddevSampOrderBy
  , sum ::
      Optional
        UsersSumOrderBy
  , var_pop ::
      Optional
        UsersVarPopOrderBy
  , var_samp ::
      Optional
        UsersVarSampOrderBy
  , variance ::
      Optional
        UsersVarianceOrderBy
  }

derive instance genericUsersAggregateOrderBy :: Generic UsersAggregateOrderBy _

derive instance newtypeUsersAggregateOrderBy :: Newtype UsersAggregateOrderBy _

instance toGraphQLArgumentValueUsersAggregateOrderBy ::
  ToGraphQLArgumentValue
    UsersAggregateOrderBy where
  toGraphQLArgumentValue (UsersAggregateOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_arr_rel_insert_input
newtype UsersArrRelInsertInput
  = UsersArrRelInsertInput
  { "data" ::
      Array
        UsersInsertInput
  , on_conflict ::
      Optional
        UsersOnConflict
  }

derive instance genericUsersArrRelInsertInput :: Generic UsersArrRelInsertInput _

derive instance newtypeUsersArrRelInsertInput :: Newtype UsersArrRelInsertInput _

instance toGraphQLArgumentValueUsersArrRelInsertInput ::
  ToGraphQLArgumentValue
    UsersArrRelInsertInput where
  toGraphQLArgumentValue (UsersArrRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - users_avg_order_by
newtype UsersAvgOrderBy
  = UsersAvgOrderBy { id :: Optional OrderBy }

derive instance genericUsersAvgOrderBy :: Generic UsersAvgOrderBy _

derive instance newtypeUsersAvgOrderBy :: Newtype UsersAvgOrderBy _

instance toGraphQLArgumentValueUsersAvgOrderBy ::
  ToGraphQLArgumentValue
    UsersAvgOrderBy where
  toGraphQLArgumentValue (UsersAvgOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_bool_exp
newtype UsersBoolExp
  = UsersBoolExp UsersBoolExp_

type UsersBoolExp_
  = { "_and" ::
        Optional
          ( Array
              ( Maybe
                  UsersBoolExp
              )
          )
    , "_not" :: Optional UsersBoolExp
    , "_or" ::
        Optional
          ( Array
              ( Maybe
                  UsersBoolExp
              )
          )
    , articles :: Optional ArticlesBoolExp
    , bio :: Optional StringComparisonExp
    , email :: Optional StringComparisonExp
    , follows :: Optional FollowsBoolExp
    , id :: Optional IntComparisonExp
    , password_hash ::
        Optional
          StringComparisonExp
    , profile_image ::
        Optional
          StringComparisonExp
    , username :: Optional StringComparisonExp
    }

derive instance genericUsersBoolExp :: Generic UsersBoolExp _

derive instance newtypeUsersBoolExp :: Newtype UsersBoolExp _

instance toGraphQLArgumentValueUsersBoolExp ::
  ToGraphQLArgumentValue
    UsersBoolExp where
  toGraphQLArgumentValue (UsersBoolExp x) = toGraphQLArgumentValue x

-- | original name - users_inc_input
newtype UsersIncInput
  = UsersIncInput { id :: Optional Int }

derive instance genericUsersIncInput :: Generic UsersIncInput _

derive instance newtypeUsersIncInput :: Newtype UsersIncInput _

instance toGraphQLArgumentValueUsersIncInput ::
  ToGraphQLArgumentValue
    UsersIncInput where
  toGraphQLArgumentValue (UsersIncInput x) = toGraphQLArgumentValue x

-- | original name - users_insert_input
newtype UsersInsertInput
  = UsersInsertInput UsersInsertInput_

type UsersInsertInput_
  = { articles :: Optional ArticlesArrRelInsertInput
    , bio :: Optional String
    , email :: Optional String
    , follows :: Optional FollowsArrRelInsertInput
    , id :: Optional Int
    , password_hash :: Optional String
    , profile_image :: Optional String
    , username :: Optional String
    }

instance defaultCreateUserInput :: DefaultInput UsersInsertInput where
  defaultInput = UsersInsertInput (defaultInput :: UsersInsertInput_)

derive instance genericUsersInsertInput :: Generic UsersInsertInput _

derive instance newtypeUsersInsertInput :: Newtype UsersInsertInput _

instance toGraphQLArgumentValueUsersInsertInput ::
  ToGraphQLArgumentValue
    UsersInsertInput where
  toGraphQLArgumentValue (UsersInsertInput x) = toGraphQLArgumentValue x

-- | original name - users_max_order_by
newtype UsersMaxOrderBy
  = UsersMaxOrderBy
  { bio :: Optional OrderBy
  , email :: Optional OrderBy
  , id :: Optional OrderBy
  , password_hash :: Optional OrderBy
  , profile_image :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericUsersMaxOrderBy :: Generic UsersMaxOrderBy _

derive instance newtypeUsersMaxOrderBy :: Newtype UsersMaxOrderBy _

instance toGraphQLArgumentValueUsersMaxOrderBy ::
  ToGraphQLArgumentValue
    UsersMaxOrderBy where
  toGraphQLArgumentValue (UsersMaxOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_min_order_by
newtype UsersMinOrderBy
  = UsersMinOrderBy
  { bio :: Optional OrderBy
  , email :: Optional OrderBy
  , id :: Optional OrderBy
  , password_hash :: Optional OrderBy
  , profile_image :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericUsersMinOrderBy :: Generic UsersMinOrderBy _

derive instance newtypeUsersMinOrderBy :: Newtype UsersMinOrderBy _

instance toGraphQLArgumentValueUsersMinOrderBy ::
  ToGraphQLArgumentValue
    UsersMinOrderBy where
  toGraphQLArgumentValue (UsersMinOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_obj_rel_insert_input
newtype UsersObjRelInsertInput
  = UsersObjRelInsertInput
  { "data" :: UsersInsertInput
  , on_conflict ::
      Optional
        UsersOnConflict
  }

derive instance genericUsersObjRelInsertInput :: Generic UsersObjRelInsertInput _

derive instance newtypeUsersObjRelInsertInput :: Newtype UsersObjRelInsertInput _

instance toGraphQLArgumentValueUsersObjRelInsertInput ::
  ToGraphQLArgumentValue
    UsersObjRelInsertInput where
  toGraphQLArgumentValue (UsersObjRelInsertInput x) = toGraphQLArgumentValue x

-- | original name - users_on_conflict
newtype UsersOnConflict
  = UsersOnConflict
  { constraint :: UsersConstraint
  , update_columns ::
      Array
        UsersUpdateColumn
  , "where" :: Optional UsersBoolExp
  }

derive instance genericUsersOnConflict :: Generic UsersOnConflict _

derive instance newtypeUsersOnConflict :: Newtype UsersOnConflict _

instance toGraphQLArgumentValueUsersOnConflict ::
  ToGraphQLArgumentValue
    UsersOnConflict where
  toGraphQLArgumentValue (UsersOnConflict x) = toGraphQLArgumentValue x

-- | original name - users_order_by
newtype UsersOrderBy
  = UsersOrderBy
  { articles_aggregate ::
      Optional
        ArticlesAggregateOrderBy
  , bio :: Optional OrderBy
  , email :: Optional OrderBy
  , follows_aggregate ::
      Optional
        FollowsAggregateOrderBy
  , id :: Optional OrderBy
  , password_hash :: Optional OrderBy
  , profile_image :: Optional OrderBy
  , username :: Optional OrderBy
  }

derive instance genericUsersOrderBy :: Generic UsersOrderBy _

derive instance newtypeUsersOrderBy :: Newtype UsersOrderBy _

instance toGraphQLArgumentValueUsersOrderBy ::
  ToGraphQLArgumentValue
    UsersOrderBy where
  toGraphQLArgumentValue (UsersOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_pk_columns_input
newtype UsersPkColumnsInput
  = UsersPkColumnsInput { id :: Int }

derive instance genericUsersPkColumnsInput :: Generic UsersPkColumnsInput _

derive instance newtypeUsersPkColumnsInput :: Newtype UsersPkColumnsInput _

instance toGraphQLArgumentValueUsersPkColumnsInput ::
  ToGraphQLArgumentValue
    UsersPkColumnsInput where
  toGraphQLArgumentValue (UsersPkColumnsInput x) = toGraphQLArgumentValue x

-- | original name - users_set_input
newtype UsersSetInput
  = UsersSetInput
  { bio :: Optional String
  , email :: Optional String
  , id :: Optional Int
  , password_hash :: Optional String
  , profile_image :: Optional String
  , username :: Optional String
  }

derive instance genericUsersSetInput :: Generic UsersSetInput _

derive instance newtypeUsersSetInput :: Newtype UsersSetInput _

instance toGraphQLArgumentValueUsersSetInput ::
  ToGraphQLArgumentValue
    UsersSetInput where
  toGraphQLArgumentValue (UsersSetInput x) = toGraphQLArgumentValue x

-- | original name - users_stddev_order_by
newtype UsersStddevOrderBy
  = UsersStddevOrderBy { id :: Optional OrderBy }

derive instance genericUsersStddevOrderBy :: Generic UsersStddevOrderBy _

derive instance newtypeUsersStddevOrderBy :: Newtype UsersStddevOrderBy _

instance toGraphQLArgumentValueUsersStddevOrderBy ::
  ToGraphQLArgumentValue
    UsersStddevOrderBy where
  toGraphQLArgumentValue (UsersStddevOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_stddev_pop_order_by
newtype UsersStddevPopOrderBy
  = UsersStddevPopOrderBy { id :: Optional OrderBy }

derive instance genericUsersStddevPopOrderBy :: Generic UsersStddevPopOrderBy _

derive instance newtypeUsersStddevPopOrderBy :: Newtype UsersStddevPopOrderBy _

instance toGraphQLArgumentValueUsersStddevPopOrderBy ::
  ToGraphQLArgumentValue
    UsersStddevPopOrderBy where
  toGraphQLArgumentValue (UsersStddevPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_stddev_samp_order_by
newtype UsersStddevSampOrderBy
  = UsersStddevSampOrderBy
  { id :: Optional OrderBy
  }

derive instance genericUsersStddevSampOrderBy :: Generic UsersStddevSampOrderBy _

derive instance newtypeUsersStddevSampOrderBy :: Newtype UsersStddevSampOrderBy _

instance toGraphQLArgumentValueUsersStddevSampOrderBy ::
  ToGraphQLArgumentValue
    UsersStddevSampOrderBy where
  toGraphQLArgumentValue (UsersStddevSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_sum_order_by
newtype UsersSumOrderBy
  = UsersSumOrderBy { id :: Optional OrderBy }

derive instance genericUsersSumOrderBy :: Generic UsersSumOrderBy _

derive instance newtypeUsersSumOrderBy :: Newtype UsersSumOrderBy _

instance toGraphQLArgumentValueUsersSumOrderBy ::
  ToGraphQLArgumentValue
    UsersSumOrderBy where
  toGraphQLArgumentValue (UsersSumOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_var_pop_order_by
newtype UsersVarPopOrderBy
  = UsersVarPopOrderBy { id :: Optional OrderBy }

derive instance genericUsersVarPopOrderBy :: Generic UsersVarPopOrderBy _

derive instance newtypeUsersVarPopOrderBy :: Newtype UsersVarPopOrderBy _

instance toGraphQLArgumentValueUsersVarPopOrderBy ::
  ToGraphQLArgumentValue
    UsersVarPopOrderBy where
  toGraphQLArgumentValue (UsersVarPopOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_var_samp_order_by
newtype UsersVarSampOrderBy
  = UsersVarSampOrderBy { id :: Optional OrderBy }

derive instance genericUsersVarSampOrderBy :: Generic UsersVarSampOrderBy _

derive instance newtypeUsersVarSampOrderBy :: Newtype UsersVarSampOrderBy _

instance toGraphQLArgumentValueUsersVarSampOrderBy ::
  ToGraphQLArgumentValue
    UsersVarSampOrderBy where
  toGraphQLArgumentValue (UsersVarSampOrderBy x) = toGraphQLArgumentValue x

-- | original name - users_variance_order_by
newtype UsersVarianceOrderBy
  = UsersVarianceOrderBy { id :: Optional OrderBy }

derive instance genericUsersVarianceOrderBy :: Generic UsersVarianceOrderBy _

derive instance newtypeUsersVarianceOrderBy :: Newtype UsersVarianceOrderBy _

instance toGraphQLArgumentValueUsersVarianceOrderBy ::
  ToGraphQLArgumentValue
    UsersVarianceOrderBy where
  toGraphQLArgumentValue (UsersVarianceOrderBy x) = toGraphQLArgumentValue x
