package org.realworld.actions.auth.doubles

import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.AuthController
import org.realworld.actions.auth.service.PasswordService
import org.realworld.actions.auth.service.StoredPassword

class AuthDoubles(
    val users: MockUsersRepository = MockUsersRepository(),
    val tokens: TokensStub = TokensStub("TOKEN")
) {
    val password: PasswordService = StoredPassword
    val auth = Auth(password, tokens, users)
    val actions = Auth.Actions(auth)
    val controller = AuthController(actions)
}