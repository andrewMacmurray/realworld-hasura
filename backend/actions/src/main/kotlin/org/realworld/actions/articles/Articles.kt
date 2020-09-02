package org.realworld.actions.articles

import org.koin.dsl.module
import org.realworld.actions.articles.actions.Unlike
import org.realworld.actions.articles.service.ArticlesRepository
import org.realworld.actions.articles.service.HasuraArticles

class Articles(val repository: ArticlesRepository) {

    class Actions(articles: Articles) {
        val unlike = Unlike(articles)
    }

    object Module {
        fun build() = module {
            single { HasuraArticles(get()) as ArticlesRepository }
            single { Articles(get()) }
            single { Actions(get()) }
            single { ArticlesController(get()) }
        }
    }
}

