package org.realworld.actions.articles

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.articles.doubles.ArticlesStub
import org.realworld.actions.bodyAs
import org.realworld.actions.post
import org.realworld.actions.utils.pipe

class ArticleControllerTest {

    private val controller = buildController()

    @Test
    fun `handles unlike article`() {
        val userIdHeader = "X-Hasura-User-Id" to "1"
        val articleId = 1
        UnlikeRequest(articleId)
            .pipe { controller.post("/unlike", it, userIdHeader) }
            .pipe { it.bodyAs<UnlikeResponse>() }
            .pipe { assertEquals(articleId, it.article_id) }
    }

    private fun buildController() =
        ArticlesStub()
            .pipe(::ArticlesActions)
            .pipe(::ArticlesController)
}