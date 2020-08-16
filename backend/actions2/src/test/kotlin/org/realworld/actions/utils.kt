package org.realworld.actions

import org.http4k.core.Request
import org.http4k.format.Jackson
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Assertions.assertTrue
import org.realworld.actions.utils.Result

// Web

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