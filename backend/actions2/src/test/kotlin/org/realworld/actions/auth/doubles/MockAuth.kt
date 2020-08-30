package org.realworld.actions.auth.doubles

import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.service.HasuraTokens
import org.realworld.actions.auth.service.StoredPassword
import org.realworld.actions.auth.service.TokenService

private val defaultTokens: TokenService =
    HasuraTokens("3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R")

val mockAuth = Auth(
    users = MockUsersRepository(),
    password = StoredPassword,
    token = defaultTokens
)