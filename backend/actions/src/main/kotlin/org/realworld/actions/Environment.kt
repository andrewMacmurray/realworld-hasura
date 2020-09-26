package org.realworld.actions

import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.module
import org.realworld.actions.articles.ArticlesModule
import org.realworld.actions.auth.AuthModule

object Environment {
    val JWT_SECRET = required("HASURA_GRAPHQL_JWT_SECRET")
    val ADMIN_SECRET = required("HASURA_GRAPHQL_ADMIN_SECRET")
    val GRAPHQL_URL = required("HASURA_GRAPHQL_URL")
    val ACTIONS_SECRET = required("ACTIONS_SECRET")
    val PORT = optional("PORT", "4000").toInt()

    private fun required(key: String): String = try {
        System.getenv(key)!!
    } catch (e: NullPointerException) {
        throw RequiredEnvVarException("Error loading $key")
    }

    private fun optional(name: String, default: String): String =
        System.getenv(name) ?: default

    class RequiredEnvVarException(message: String) : RuntimeException(message)
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