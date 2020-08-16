package org.realworld.actions.auth

import org.http4k.core.Body
import org.http4k.core.Method
import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.format.Jackson.auto
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.realworld.actions.auth.doubles.MockAuth
import org.realworld.actions.auth.doubles.TokensStub
import org.realworld.actions.json
import org.realworld.actions.utils.pipe
import org.realworld.actions.web.Controller
import org.realworld.actions.web.LambdaInput

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
            .pipe { controller.post("/signup", it) }
            .pipe { it.bodyAs<SignupResponse>() }
            .pipe { assertEquals(token, it.token) }
    }
}

inline fun <reified T : Any> Response.bodyAs(): T =
    Body.auto<T>().toLens()(this)

private fun <I : Any> Controller.post(url: String, input: I): Response =
    LambdaInput(input)
        .pipe { Request(Method.POST, url).json(it) }
        .pipe { this.handle(it) }
