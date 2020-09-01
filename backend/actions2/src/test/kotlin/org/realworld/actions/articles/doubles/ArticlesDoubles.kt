package org.realworld.actions.articles.doubles

import org.realworld.actions.articles.Articles
import org.realworld.actions.articles.ArticlesController
import org.realworld.actions.utils.pipe

class ArticlesDoubles {
    val controller = ArticlesRepositoryStub()
        .pipe(::Articles)
        .pipe(Articles::Actions)
        .pipe(::ArticlesController)
}