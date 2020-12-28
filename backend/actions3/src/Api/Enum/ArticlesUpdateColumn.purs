module Api.Enum.ArticlesUpdateColumn where

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

-- | original name - articles_update_column
data ArticlesUpdateColumn = About | Content | Title

derive instance genericArticlesUpdateColumn :: Generic ArticlesUpdateColumn _

instance showArticlesUpdateColumn :: Show ArticlesUpdateColumn where
  show = genericShow

derive instance eqArticlesUpdateColumn :: Eq ArticlesUpdateColumn

derive instance ordArticlesUpdateColumn :: Ord ArticlesUpdateColumn

fromToMap :: Array (Tuple String ArticlesUpdateColumn)
fromToMap = [ Tuple "about" About
            , Tuple "content" Content
            , Tuple "title" Title
            ]

instance articlesUpdateColumnGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                                    ArticlesUpdateColumn where
  graphqlDefaultResponseScalarDecoder = enumDecoder
                                        "ArticlesUpdateColumn"
                                        fromToMap

instance articlesUpdateColumnToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                       ArticlesUpdateColumn where
  toGraphQLArgumentValue =
    case _ of
      About -> ArgumentValueEnum "about"
      Content -> ArgumentValueEnum "content"
      Title -> ArgumentValueEnum "title"
