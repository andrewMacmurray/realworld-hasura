package org.realworld.actions.web

import org.http4k.core.*
import org.http4k.format.Jackson
import org.http4k.format.Jackson.auto
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.User
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe

object UserHandler {
    inline operator fun <reified In : Any, Out : Any> invoke(crossinline handler: (In, User.Id) -> ActionResult<Out>) =
        { req: Request ->
            req.parseBody<UserActionRequest<In>>()
                .pipe { handler(it.input, User.Id(it.session.userId.toInt())) }
                .pipe { it.json() }
        }
}

object Handler {
    inline operator fun <reified In : Any, Out : Any> invoke(crossinline handler: (In) -> ActionResult<Out>) =
        { req: Request ->
            req.parseBody<ActionRequest<In>>()
                .pipe { handler(it.input) }
                .pipe { it.json() }
        }
}

fun <O : Any> ActionResult<O>.json(): Response {
    return when (this) {
        is Result.Ok -> Response(Status.OK).json(this.value)
        is Result.Err -> error(Status.BAD_REQUEST, err)
    }
}

inline fun <reified A : Any> HttpMessage.parseBody(): A =
    Body.auto<A>().toLens()(this)

private fun error(status: Status, message: String): Response =
    ActionError(message, status).pipe { Response(status).json(it) }

private fun <T : Any> Response.json(body: T): Response =
    this.body(Jackson.asJsonString(body))