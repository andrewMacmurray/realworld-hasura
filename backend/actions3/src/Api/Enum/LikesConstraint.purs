module Api.Enum.LikesConstraint where

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

-- | original name - likes_constraint
data LikesConstraint = FavouritesPkey | LikesUserIdArticleIdKey

derive instance genericLikesConstraint :: Generic LikesConstraint _

instance showLikesConstraint :: Show LikesConstraint where
  show = genericShow

derive instance eqLikesConstraint :: Eq LikesConstraint

derive instance ordLikesConstraint :: Ord LikesConstraint

fromToMap :: Array (Tuple String LikesConstraint)
fromToMap = [ Tuple "favourites_pkey" FavouritesPkey
            , Tuple "likes_user_id_article_id_key" LikesUserIdArticleIdKey
            ]

instance likesConstraintGraphQLDefaultResponseScalarDecoder :: GraphQLDefaultResponseScalarDecoder
                                                               LikesConstraint where
  graphqlDefaultResponseScalarDecoder = enumDecoder "LikesConstraint" fromToMap

instance likesConstraintToGraphQLArgumentValue :: ToGraphQLArgumentValue
                                                  LikesConstraint where
  toGraphQLArgumentValue =
    case _ of
      FavouritesPkey -> ArgumentValueEnum "favourites_pkey"
      LikesUserIdArticleIdKey -> ArgumentValueEnum
                                 "likes_user_id_article_id_key"
