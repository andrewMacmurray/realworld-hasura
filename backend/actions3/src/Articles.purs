module Articles where

import Prelude
import Api.InputObject (IntComparisonExp(..), IntComparisonExp_, LikesBoolExp(..), LikesBoolExp_)
import Api.Mutation (DeleteLikesInput)
import Api.Mutation as Mutation
import Api.Object.Likes as Likes
import Api.Object.LikesMutationResponse (returning)
import Api.Scopes (Scope__LikesMutationResponse)
import GraphQLClient (Optional(..), Scope__RootMutation, SelectionSet, defaultInput, nonNullOrFail)
import Hasura as Hasura
import Users as Users

type ArticleToUnlike
  = { userId :: Users.Id
    , articleId :: ArticleId
    }

type ArticleId
  = Int

unlike :: ArticleToUnlike -> Hasura.Response ArticleId
unlike = unlikeMutation >>> Hasura.mutation

unlikeMutation :: ArticleToUnlike -> SelectionSet Scope__RootMutation ArticleId
unlikeMutation article = nonNullOrFail $ Mutation.delete_likes (input article) (unlikeSelection article.articleId)

unlikeSelection :: ArticleId -> SelectionSet Scope__LikesMutationResponse ArticleId
unlikeSelection id = const id <$> returning Likes.article_id

input :: ArticleToUnlike -> DeleteLikesInput
input article =
  { "where":
      LikesBoolExp
        ( defaults
            { user_id = equals article.userId
            , article_id = equals article.articleId
            }
        )
  }
  where
  defaults :: LikesBoolExp_
  defaults = defaultInput

equals :: Int -> Optional IntComparisonExp
equals n = Present (IntComparisonExp ((defaultInput :: IntComparisonExp_) { "_eq" = Present n }))
