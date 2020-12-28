module Api.Enum.ArticlesSelectColumn where

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

-- | original name - articles_select_column
data ArticlesSelectColumn = About | Content | CreatedAt | Id | Title

derive instance genericArticlesSelectColumn :: Generic ArticlesSelectColumn _

instance showArticlesSelectColumn :: Show ArticlesSelectColumn where
  show = genericShow

derive instance eqArticlesSelectColumn :: Eq ArticlesSelectColumn

derive instance ordArticlesSelectColumn :: Ord ArticlesSelectColumn

fromToMap :: Array (Tuple String ArticlesSelectColumn)
fromToMap = [ Tuple "about" About
            , Tuple "content" Content
            , Tuple "created_at" CreatedAt
            , Tuple "id" Id
            , Tuple "title" Title
            ]

instance articlesSelectColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                    ArticlesSelectColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "ArticlesSelectColumn"
                                        fromToMap

instance articlesSelectColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                       ArticlesSelectColumn where
  toGraphQLArgumentValue =
    case _ of
      About -> ArgumentValueEnum "about"
      Content -> ArgumentValueEnum "content"
      CreatedAt -> ArgumentValueEnum "created_at"
      Id -> ArgumentValueEnum "id"
      Title -> ArgumentValueEnum "title"
