package org.realworld.actions

import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Assertions.assertTrue
import org.realworld.actions.utils.Result

fun <Err, Ok> assertOnOkValue(
    result: Result<Err, Ok>,
    assertWhenOk: (Ok) -> Unit
) {
    when (result) {
        is Result.Ok -> assertWhenOk(result.value)
        is Result.Err -> Assertions.fail("${result.err} is not Ok")
    }
}

fun <Left, Right> assertIsOk(result: Result<Left, Right>) {
    when (result) {
        is Result.Ok -> pass()
        is Result.Err -> Assertions.fail("${result.err} is not Ok")
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