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
    result.assertWhenOk { pass() }
}

fun <Left, Right> Result<Left, Right>.assertWhenOk(assertion: (Right) -> Unit) {
    when (this) {
        is Result.Ok -> assertion(this.value)
        is Result.Err -> Assertions.fail("${this.err} is not Ok")
    }
}

fun <Err, Ok> assertIsError(result: Result<Err, Ok>) {
    when (result) {
        is Result.Ok -> Assertions.fail("${result.value} should be an Error")
        is Result.Err -> pass()
    }
}

private fun pass() {
    assertTrue(true)
}