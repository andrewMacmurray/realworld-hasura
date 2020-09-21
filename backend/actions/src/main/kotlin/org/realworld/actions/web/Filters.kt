package org.realworld.actions.web

import org.http4k.core.*
import org.http4k.filter.RequestFilters
import org.http4k.lens.Header

object AuthorizationFilter {
    operator fun invoke(secret: String) = Filter { next ->
        { request ->
            if (request.isAuthorized(secret)) {
                next(request)
            } else {
                println("invalid actions secret")
                actionError(Status.UNAUTHORIZED, "something went wrong")
            }
        }
    }

    private fun Request.isAuthorized(secret: String) =
        actionsSecret(this) == secret

    private fun actionsSecret(request: Request): String? =
        Header.optional("actions-secret")(request)
}

object LogFilter {
    operator fun invoke(): Filter =
        logRequest().then(logResponse())

    private fun logRequest(): Filter =
        RequestFilters.Tap { print("${it.method} ${it.uri} ${it.body} ${it.headers}") }

    private fun logResponse(): Filter =
        Filter { next: HttpHandler -> { printResponse(next, it) } }

    private fun printResponse(next: HttpHandler, request: Request): Response =
        Timed { next(request) }.traceWith(::responseMessage)

    private fun responseMessage(it: Timed.Result<Response>) =
        " -- ${it.value.status} -- ${it.latency} ms"
}

object Timed {
    operator fun <T> invoke(fn: () -> T): Result<T> {
        val start = now()
        val value = fn()
        val latency = now() - start
        return Result(latency, value)
    }

    private fun now(): Long =
        System.currentTimeMillis()

    data class Result<T>(val latency: Long, val value: T) {
        fun traceWith(fn: (Result<T>) -> String): T {
            println(fn(this))
            return value
        }
    }
}
