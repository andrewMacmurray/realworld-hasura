package org.realworld.actions.auth

import org.http4k.core.Body
import org.http4k.core.Method.POST
import org.http4k.core.Request
import org.http4k.format.Jackson
import org.http4k.format.Jackson.auto
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.doubles.MockAuth
import org.realworld.actions.auth.doubles.TokensStub
import org.realworld.actions.web.Controller
import org.realworld.actions.utils.pipe

class AuthControllerTest {

    private val token = "TOKEN"
    private val auth = MockAuth(token = TokensStub(token))
    private val signup = Signup(auth)
    private val controller: Controller = AuthController(signup)

    @Test
    fun `handles signup`() {
        SignupRequest(
            username = "andrew",
            email = "a@b.com",
            password = "Abc12345!"
        )
            .pipe { Jackson.asJsonString(it) }
            .pipe { Request(POST, "/signup").body(it) }
            .pipe { controller.handle(it) }
            .pipe { Body.auto<SignupResponse>().toLens()(it) }
            .pipe { assertEquals(token, it.token.value) }
    }
}