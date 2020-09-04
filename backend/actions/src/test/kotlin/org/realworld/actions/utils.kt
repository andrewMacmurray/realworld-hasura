package org.realworld.actions

import org.http4k.core.Method
import org.http4k.core.Request
import org.http4k.core.Response
import org.http4k.format.Jackson
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Assertions.assertTrue
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.pipe
import org.realworld.actions.web.ActionRequest
import org.realworld.actions.web.Controller
import org.realworld.actions.web.UserActionRequest

// Web

fun <I : Any> Controller.post(url: String, input: I): Response =
    ActionRequest(input)
        .pipe { Request(Method.POST, url).json(it) }
        .pipe { this.handler(it) }

fun <I : Any> Controller.postForUser(url: String, userId: Int, input: I): Response =
    input.toUserAction(userId)
        .pipe { Request(Method.POST, url).json(it) }
        .pipe { this.handler(it) }

private fun <I> I.toUserAction(userId: Int) =
    UserActionRequest(
        input = this,
        session = UserActionRequest.Session(userId = "$userId")
    )

fun <T : Any> Request.json(body: T): Request =
    this.body(Jackson.asJsonString(body))


// Result

fun <Left, Right> assertIsOk(result: Result<Left, Right>) {
    result.whenOk { pass() }
}

fun <Left, Right> Result<Left, Right>.whenOk(assertion: (Right) -> Unit) {
    when (this) {
        is Result.Ok -> assertion(this.value)
        is Result.Err -> Assertions.fail("${this.err} is not Ok")
    }
}

fun <Err, Ok> assertIsError(result: Result<Err, Ok>) {
    result.whenError { pass() }
}

fun <Left, Right> Result<Left, Right>.whenError(assertion: (Left) -> Unit) {
    when (this) {
        is Result.Ok -> Assertions.fail("${this.value} should be Error")
        is Result.Err -> assertion(this.err)
    }
}

private fun pass() {
    assertTrue(true)
}