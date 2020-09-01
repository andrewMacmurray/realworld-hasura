package org.realworld.actions.articles.service

import com.expediagroup.graphql.types.GraphQLResponse
import kotlinx.coroutines.runBlocking
import org.realworld.actions.HasuraClient
import org.realworld.actions.articles.Article
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.utils.toResult
import org.realworld.generated.UnlikeArticleMutation

interface ArticlesRepository {
    fun unlike(article: Article.Unlike): Result<String, Article.Id>
}

class HasuraArticles(private val client: HasuraClient) : ArticlesRepository {

    override fun unlike(article: Article.Unlike): Result<String, Article.Id> = runBlocking {
        article.variables()
            .pipe { UnlikeArticleMutation(client).execute(it) }
            .pipe { toResponse(it) }
    }

    private fun toResponse(response: GraphQLResponse<UnlikeArticleMutation.Result>) =
        articleId(response)
            ?.pipe(Article::Id)
            .toResult("Error deleting article likes")

    private fun articleId(response: GraphQLResponse<UnlikeArticleMutation.Result>) =
        response.data?.delete_likes?.returning?.get(0)?.article_id

    private fun Article.Unlike.variables() =
        UnlikeArticleMutation.Variables(
            userId = userId.value,
            articleId = id.value
        )
}
