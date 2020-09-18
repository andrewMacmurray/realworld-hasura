package org.realworld.actions.auth.doubles

import org.realworld.actions.auth.Auth
import org.realworld.actions.auth.Auth.Actions
import org.realworld.actions.auth.web.AuthController
import org.realworld.actions.auth.service.StoredPassword

class AuthDoubles {
    val users = MockUsersRepository()
    val tokens = TokensStub("TOKEN")
    val actions = Actions(Auth(StoredPassword, tokens, users))
    val controller = AuthController(actions)
}