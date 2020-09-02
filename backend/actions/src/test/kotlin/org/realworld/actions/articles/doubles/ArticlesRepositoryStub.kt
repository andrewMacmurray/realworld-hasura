package org.realworld.actions.articles.doubles

import org.realworld.actions.articles.Article
import org.realworld.actions.articles.service.ArticlesRepository
import org.realworld.actions.utils.Result

class ArticlesRepositoryStub : ArticlesRepository {
    override fun unlike(article: Article.Unlike): Result<String, Article.Id> =
        Result.Ok(article.id)
}