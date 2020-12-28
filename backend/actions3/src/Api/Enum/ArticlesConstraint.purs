module Api.Enum.ArticlesConstraint where

import Data.Generic.Rep (class Generic)
import Data.Show (class Show)
import Data.Generic.Rep.Show (genericShow)
import Prelude (class Eq, class Ord)
import Data.Tuple (Tuple(..))
import GraphQLClient
  ( class GraphQLDefaultResponseScalarDecoder
  , enumDecoder
  , class ToGraphQLArgumentValue
  , ArgumentValue(..)
  )

-- | original name - articles_constraint
data ArticlesConstraint = ArticlesPkey

derive instance genericArticlesConstraint :: Generic ArticlesConstraint _

instance showArticlesConstraint :: Show ArticlesConstraint where
  show = genericShow

derive instance eqArticlesConstraint :: Eq ArticlesConstraint

derive instance ordArticlesConstraint :: Ord ArticlesConstraint

fromToMap :: Array (Tuple String ArticlesConstraint)
fromToMap = [ Tuple "articles_pkey" ArticlesPkey ]

instance articlesConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                  ArticlesConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "ArticlesConstraint"
                                        fromToMap

instance articlesConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                     ArticlesConstraint where
  toGraphQLArgumentValue =
    case _ of
      ArticlesPkey -> ArgumentValueEnum "articles_pkey"
