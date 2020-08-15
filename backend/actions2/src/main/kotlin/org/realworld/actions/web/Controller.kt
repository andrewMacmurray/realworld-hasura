package org.realworld.actions.web

import org.http4k.core.Body
import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.core.Status
import org.http4k.format.Jackson
import org.http4k.format.Jackson.auto
import org.http4k.routing.RoutingHttpHandler
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe

interface Controller {
    val handle: RoutingHttpHandler
}

inline fun <reified In : Any, Out : Any> jsonHandler(crossinline handler: (In) -> Result<String, Out>) =
    { req: Request ->
        Body.auto<In>().toLens()(req)
            .pipe { handler(it) }
            .pipe { it.jsonResponse() }
    }

fun <O : Any> Result<String, O>.jsonResponse(): Response {
    return when (this) {
        is Result.Ok -> Response(Status.OK).json(this.value)
        is Result.Err -> Response(Status.BAD_REQUEST).body(this.err)
    }
}

private fun <T : Any> Response.json(body: T): Response =
    this.body(Jackson.asJsonString(body))

