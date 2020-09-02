package org.realworld.actions

import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.module
import org.realworld.actions.articles.Articles
import org.realworld.actions.auth.Auth

object Environment {
    val JWT_SECRET = System.getenv("HASURA_GRAPHQL_JWT_SECRET")!!
    val ADMIN_SECRET = System.getenv("HASURA_GRAPHQL_ADMIN_SECRET")!!
    val GRAPHQL_URL = System.getenv("HASURA_GRAPHQL_URL")!!
}

object Context {
    fun create() {
        startKoin {
            printLogger()
            modules(*allModules)
        }
    }

    private val globalModule = module {
        single { Environment }
        single { ClientBuilder(get()).build() }
    }

    private val allModules: Array<Module> = arrayOf(
        globalModule,
        Auth.Module.build(),
        Articles.Module.build()
    )
}