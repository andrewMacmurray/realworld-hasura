package org.realworld.actions.articles

import org.koin.dsl.module
import org.realworld.actions.articles.actions.Unlike
import org.realworld.actions.articles.service.ArticlesRepository
import org.realworld.actions.articles.service.HasuraArticles

interface Articles {
    val repository: ArticlesRepository
}

class ArticlesComponents(
    override val repository: ArticlesRepository
) : Articles

class ArticlesActions(articles: Articles) {
    val unlike = Unlike(articles)
}

object ArticlesModule {
    fun build() = module {
        single { HasuraArticles(get()) as ArticlesRepository }
        single { ArticlesComponents(get()) as Articles }
        single { ArticlesActions(get()) }
        single { ArticlesController(get()) }
    }
}