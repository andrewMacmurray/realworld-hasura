package org.realworld.actions.articles

import org.realworld.actions.auth.User

data class UnlikeRequest(val article_id: Int)
data class UnlikeResponse(val article_id: Int)

fun UnlikeRequest.toUnlike(userId: User.Id) = Article.Unlike(
    id = Article.Id(article_id),
    userId = userId
)

fun Article.Id.toUnlikeResponse() =
    UnlikeResponse(article_id = this.value)
