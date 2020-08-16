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

inline fun <reified In : Any, Out : Any> actionHandler(crossinline handler: (In) -> Result<String, Out>) =
    { req: Request ->
        Body.auto<ActionInput<In>>().toLens()(req)
            .pipe { handler(it.input) }
            .pipe { it.jsonResponse() }
    }

fun <O : Any> Result<String, O>.jsonResponse(): Response {
    return when (this) {
        is Result.Ok -> Response(Status.OK).json(this.value)
        is Result.Err -> toActionError(Status.BAD_REQUEST, this.err)
    }
}

private fun toActionError(status: Status, message: String): Response =
    ActionErrorResponse(message, status).pipe { Response(status).json(it) }

data class ActionInput<T>(val input: T)

data class ActionErrorResponse(val message: String, private val status: Status) {
    val code: String = "${status.code}"
}

private fun <T : Any> Response.json(body: T): Response =
    this.body(Jackson.asJsonString(body))

