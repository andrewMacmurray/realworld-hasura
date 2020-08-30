package org.realworld.actions.articles

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.articles.doubles.ArticlesStub
import org.realworld.actions.bodyAs
import org.realworld.actions.postForUser
import org.realworld.actions.utils.pipe

class ArticleControllerTest {

    private val controller = buildController()

    @Test
    fun `handles unlike article`() {
        val articleId = 1
        val userId = 2
        UnlikeRequest(articleId)
            .pipe { controller.postForUser("/unlike", userId, it) }
            .pipe { it.bodyAs<UnlikeResponse>() }
            .pipe { assertEquals(articleId, it.article_id) }
    }

    private fun buildController() =
        ArticlesStub()
            .pipe(::ArticlesActions)
            .pipe(::ArticlesController)
}