package org.realworld.actions.articles.service

import com.expediagroup.graphql.types.GraphQLResponse
import kotlinx.coroutines.runBlocking
import org.realworld.actions.HasuraClient
import org.realworld.actions.articles.Article
import org.realworld.actions.articles.Article.Id
import org.realworld.actions.articles.Article.Unlike
import org.realworld.actions.articles.service.Mappers.variables
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.utils.toResult
import org.realworld.generated.UnlikeArticleMutation

// Articles

interface ArticlesRepository {
    fun unlike(article: Unlike): Result<String, Id>
}

// Hasura Articles

class HasuraArticles(private val client: HasuraClient) : ArticlesRepository {

    override fun unlike(article: Unlike): Result<String, Id> = runBlocking {
        article.variables()
            .pipe { unlikeMutation(it) }
            .pipe { toResponse(it) }
    }

    private suspend fun unlikeMutation(variables: UnlikeArticleMutation.Variables) =
        UnlikeArticleMutation(client).execute(variables)

    private fun toResponse(response: GraphQLResponse<UnlikeArticleMutation.Result>) =
        articleId(response)
            ?.pipe(Article::Id)
            .toResult("Error deleting article likes")

    private fun articleId(response: GraphQLResponse<UnlikeArticleMutation.Result>) =
        response.data
            ?.delete_likes
            ?.returning
            ?.get(0)
            ?.article_id
}

private object Mappers {
    fun Unlike.variables() = UnlikeArticleMutation.Variables(
        userId = userId.value,
        articleId = id.value
    )
}
