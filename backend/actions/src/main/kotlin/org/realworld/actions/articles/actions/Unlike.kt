package org.realworld.actions.articles.actions

import org.realworld.actions.Action
import org.realworld.actions.ActionResult
import org.realworld.actions.articles.Article
import org.realworld.actions.articles.Articles

class Unlike(private val articles: Articles) : Action<Article.Unlike, Article.Id> {
    override fun process(input: Article.Unlike): ActionResult<Article.Id> =
        articles.repository.unlike(input)
}