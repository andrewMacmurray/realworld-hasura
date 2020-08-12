package org.realworld.actions

import org.http4k.core.Body
import org.http4k.core.Method.GET
import org.http4k.core.Method.POST
import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.core.Status.Companion.OK
import org.http4k.format.Jackson
import org.http4k.format.Jackson.auto
import org.http4k.routing.bind
import org.http4k.routing.routes

object Actions {
    val handler = routes(
        "/login" bind POST to Handlers::body,
        "/signup" bind POST to Handlers::body
    )
}

object Handlers {

    fun fancyBread(body: FancyRequestBody): Bread =
        Bread("Hello Fancy! ${body.message}")

    fun bread(): Response =
        Response(OK).json(Bread("I LOVE BREAD!"))

    fun hello(): Response =
        Response(OK).body("Hello World!")

    fun body(req: Request): Response =
        requestBody<Bread>(req).pipe { Response(OK).json(it) }
}

data class Bread(val message: String)
data class FancyRequestBody(val message: String)

// Helpers

private inline fun <reified T : Any> requestBody(req: Request): T =
    Body.auto<T>().toLens()(req)

private fun <T : Any> Response.json(body: T): Response =
    this.body(Jackson.asJsonString(body))

inline fun <reified I : Any, O : Any> jsonHandler(crossinline handler: (I) -> O): (Request) -> Response {
    return { req: Request ->
        Body.auto<I>().toLens()(req)
            .pipe { handler(it) }
            .pipe { Response(OK).body(Jackson.asJsonString(it)) }
    }
}

inline infix fun <P1, R> P1.pipe(t: (P1) -> R): R = t(this)
