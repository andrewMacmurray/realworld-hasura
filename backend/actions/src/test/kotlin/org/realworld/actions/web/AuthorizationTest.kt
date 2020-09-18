package org.realworld.actions.web

import org.http4k.core.*
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.utils.pipe

class AuthorizationTest {

    private val secret = "secret"
    private val handler = AuthorizationFilter(secret).then { Response(Status.OK) }

    @Test
    fun `allows requests with correct actions secret`() {
        request()
            .withSecret(secret)
            .pipe { handler(it) }
            .pipe { assertEquals(Status.OK, it.status) }
    }

    @Test
    fun `denys requests without secret`() {
        request()
            .pipe { handler(it) }
            .pipe { assertEquals(Status.UNAUTHORIZED, it.status) }
    }

    @Test
    fun `denys requests with invalid secret`() {
        request()
            .withSecret("not-so-secret")
            .pipe { handler(it) }
            .pipe { assertEquals(Status.UNAUTHORIZED, it.status) }
    }

    private fun Request.withSecret(secret: String): Request =
        this.header("actions-secret", secret)

    private fun request(): Request =
        Request(Method.POST, "/")
}

