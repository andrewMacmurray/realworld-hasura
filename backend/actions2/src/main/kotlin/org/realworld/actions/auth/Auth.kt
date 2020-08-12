package org.realworld.actions.auth

import org.realworld.actions.auth.service.PasswordService
import org.realworld.actions.auth.service.TokenService
import org.realworld.actions.auth.service.UsersRepository

class Auth(
    val password: PasswordService,
    val token: TokenService,
    val users: UsersRepository
)