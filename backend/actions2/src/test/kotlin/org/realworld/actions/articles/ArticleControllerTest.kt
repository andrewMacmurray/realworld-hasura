package org.realworld.actions.articles

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.articles.doubles.ArticlesDoubles
import org.realworld.actions.parseBody
import org.realworld.actions.postForUser
import org.realworld.actions.utils.pipe

class ArticleControllerTest {

    private val doubles = ArticlesDoubles()
    private val controller = doubles.controller

    @Test
    fun `handles unlike article`() {
        val articleId = 1
        val userId = 2
        UnlikeRequest(articleId)
            .pipe { unlike(userId, it) }
            .pipe { assertEquals(articleId, it.article_id) }
    }

    private fun unlike(userId: Int, request: UnlikeRequest): UnlikeResponse =
        controller.postForUser("/unlike", userId, request).parseBody()
}