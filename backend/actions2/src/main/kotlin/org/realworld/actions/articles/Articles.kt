package org.realworld.actions.articles

import org.realworld.actions.HasuraClient
import org.realworld.actions.articles.actions.Unlike
import org.realworld.actions.articles.service.ArticlesRepository
import org.realworld.actions.articles.service.HasuraArticles

interface Articles {
    val repository: ArticlesRepository
}

class ArticlesActions(articles: Articles) {
    val unlike = Unlike(articles)
}

class ArticlesComponents(client: HasuraClient) : Articles {
    override val repository: ArticlesRepository =
        HasuraArticles(client)
}