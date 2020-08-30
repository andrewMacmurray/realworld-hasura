package org.realworld.actions.auth

import org.koin.dsl.module
import org.realworld.actions.Environment
import org.realworld.actions.auth.actions.Login
import org.realworld.actions.auth.actions.Signup
import org.realworld.actions.auth.service.*

data class Auth(
    val password: PasswordService,
    val token: TokenService,
    val users: UsersRepository
) {
    class Actions(auth: Auth) {
        val login = Login(auth)
        val signup = Signup(auth)
    }

    object Module {
        fun build() = module {
            single { StoredPassword as PasswordService }
            single { HasuraUsers(get()) as UsersRepository }
            single { HasuraTokens((get() as Environment).JWT_SECRET) as TokenService }
            single { Auth(get(), get(), get()) }
            single { Actions(get()) }
            single { AuthController(get()) }
        }
    }
}

