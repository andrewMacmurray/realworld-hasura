package org.realworld.actions.web

import org.http4k.core.Filter
import org.http4k.core.Request
import org.http4k.core.Status
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