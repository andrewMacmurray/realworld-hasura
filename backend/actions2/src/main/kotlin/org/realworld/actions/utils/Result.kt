package org.realworld.actions.utils

sealed class Result<E, O> {
    class Ok<E, O>(val value: O) : Result<E, O>()
    class Err<E, O>(val err: E) : Result<E, O>()
}

fun <O, E> O?.toResult(err: E): Result<E, O> =
    if (this != null) {
        Result.Ok(this)
    } else {
        Result.Err(err)
    }

fun <A, B, E> Result<E, A>.map(f: (A) -> B): Result<E, B> =
    when (this) {
        is Result.Ok -> Result.Ok(f(this.value))
        is Result.Err -> Result.Err(this.err)
    }

fun <O, E, E2> Result<E, O>.mapError(f: (E) -> E2): Result<E2, O> =
    when (this) {
        is Result.Ok -> Result.Ok(this.value)
        is Result.Err -> Result.Err(f(this.err))
    }

fun <A, B, E> Result<E, A>.andThen(f: (A) -> Result<E, B>): Result<E, B> =
    when (this) {
        is Result.Ok -> f(this.value)
        is Result.Err -> Result.Err(this.err)
    }