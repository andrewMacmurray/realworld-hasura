package org.realworld.actions.articles.web

import org.realworld.actions.articles.Article
import org.realworld.actions.auth.User

data class UnlikeRequest(val article_id: Int) {
    fun toUnlike(userId: User.Id) = Article.Unlike(
        id = Article.Id(article_id),
        userId = userId
    )
}

data class UnlikeResponse(val article_id: Int)

fun Article.Id.toUnlikeResponse() =
    UnlikeResponse(article_id = value)
