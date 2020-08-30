package org.realworld.actions.web

import com.fasterxml.jackson.annotation.JsonProperty
import org.http4k.core.Status

data class ActionRequest<T>(val input: T)

data class UserActionRequest<T>(
    val input: T,
    @JsonProperty("session_variables")
    val session: Session
) {
    data class Session(
        @JsonProperty("x-hasura-user-id")
        val userId: String
    )
}

data class ActionError(val message: String, private val status: Status) {
    val code: String = "${status.code}"
}
