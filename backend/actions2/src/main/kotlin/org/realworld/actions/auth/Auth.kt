package org.realworld.actions.auth

import org.realworld.actions.auth.service.*
import org.realworld.actions.hasura.Client

interface Auth {
    val password: PasswordService
    val token: TokenService
    val users: UsersRepository
}

class AuthServices : Auth {
    private val client = Client.build()
    override val password: PasswordService = StoredPassword
    override val token: TokenService = HasuraTokens("ilovebread")
    override val users: UsersRepository = HasuraUsers(client)
}