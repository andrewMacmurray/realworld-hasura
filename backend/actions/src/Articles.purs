module Articles where

import Prelude
import Hasura as Hasura
import Users as Users

type ArticleToUnlike
  = { user_id :: Users.Id
    , article_id :: ArticleId
    }

type ArticleId
  = Int

unlike :: ArticleToUnlike -> Hasura.Response ArticleId
unlike toUnlike = do
  toSelection toUnlike <$> Hasura.request { query: unlikeMutation, variables: toUnlike }

toSelection :: ArticleToUnlike -> {} -> ArticleId
toSelection article _ = article.article_id

unlikeMutation :: String
unlikeMutation =
  """
  mutation Unlike($user_id: Int, $article_id: Int) {
    delete_likes(where: {_and: {article_id: {_eq: $article_id}, user_id: {_eq: $user_id}}}) {
      affected_rows
    }
  }
"""
