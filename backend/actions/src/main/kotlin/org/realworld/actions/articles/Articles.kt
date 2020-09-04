package org.realworld.actions.articles

import org.koin.dsl.module
import org.realworld.actions.articles.actions.Unlike
import org.realworld.actions.articles.service.ArticlesRepository
import org.realworld.actions.articles.service.HasuraArticles
import org.realworld.actions.articles.web.ArticlesController

class Articles(val repository: ArticlesRepository) {
    class Actions(articles: Articles) {
        val unlike = Unlike(articles)
    }
}

object ArticlesModule {
    fun build() = module {
        single { HasuraArticles(get()) as ArticlesRepository }
        single { Articles(get()) }
        single { Articles.Actions(get()) }
        single { ArticlesController(get()) }
    }
}

