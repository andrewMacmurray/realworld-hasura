package org.realworld.actions.web

import org.http4k.core.Status

data class ActionInput<T>(val input: T)

data class ActionError(val message: String, private val status: Status) {
    val code: String = "${status.code}"
}
