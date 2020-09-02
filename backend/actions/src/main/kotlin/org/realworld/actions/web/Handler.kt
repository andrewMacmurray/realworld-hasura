package org.realworld.actions.web

import org.http4k.core.Body
import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.core.Status
import org.http4k.format.Jackson
import org.http4k.format.Jackson.auto
import org.realworld.actions.ActionResult
import org.realworld.actions.auth.User
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe

object Action {
    inline fun <reified In : Any, Out : Any> handle(crossinline handler: (i: In) -> ActionResult<Out>) =
        { req: Request ->
            Body.auto<ActionRequest<In>>().toLens()(req)
                .pipe { handler(it.input) }
                .pipe { it.json() }
        }

    inline fun <reified In : Any, Out : Any> handleForUser(crossinline handler: (In, User.Id) -> ActionResult<Out>) =
        { req: Request ->
            val body = Body.auto<UserActionRequest<In>>().toLens()(req)
            handler(body.input, User.Id(body.session.userId.toInt())).json()
        }
}

fun <O : Any> ActionResult<O>.json(): Response {
    return when (this) {
        is Result.Ok -> Response(Status.OK).json(this.value)
        is Result.Err -> error(Status.BAD_REQUEST, err)
    }
}

private fun error(status: Status, message: String): Response =
    ActionError(message, status).pipe { Response(status).json(it) }

private fun <T : Any> Response.json(body: T): Response =
    this.body(Jackson.asJsonString(body))