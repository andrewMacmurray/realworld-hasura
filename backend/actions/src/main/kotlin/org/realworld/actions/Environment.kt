package org.realworld.actions

import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.module
import org.realworld.actions.articles.ArticlesModule
import org.realworld.actions.auth.AuthModule

object Environment {
    val JWT_SECRET = load("HASURA_GRAPHQL_JWT_SECRET")
    val ADMIN_SECRET = load("HASURA_GRAPHQL_ADMIN_SECRET")
    val GRAPHQL_URL = load("HASURA_GRAPHQL_URL")
    val ACTIONS_SECRET = load("ACTIONS_SECRET")

    private fun load(key: String): String = try {
        System.getenv(key)!!
    } catch (e: Exception) {
        throw Exception("Error loading $key")
    }
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
        AuthModule.build(),
        ArticlesModule.build()
    )
}