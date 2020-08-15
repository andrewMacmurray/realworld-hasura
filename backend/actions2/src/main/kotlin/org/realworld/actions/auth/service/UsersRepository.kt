package org.realworld.actions.auth.service

import com.expediagroup.graphql.client.GraphQLClient
import kotlinx.coroutines.runBlocking
import org.realworld.actions.auth.User
import org.realworld.actions.utils.pipe
import org.realworld.generated.CreateUser

interface UsersRepository {
    fun create(user: User.ToCreate): User
}

class HasuraUsers(private val client: GraphQLClient<*>) : UsersRepository {
    override fun create(user: User.ToCreate): User = runBlocking {
        user.variables()
            .pipe { CreateUser(client).execute(it) }
            .pipe { it.data?.create_user!!.toUser() }
    }
}

private fun User.ToCreate.variables() = CreateUser.Variables(
    username = this.username,
    email = this.email,
    password_hash = this.passwordHash
)

private fun CreateUser.users.toUser() = User(
    id = this.id,
    username = this.username,
    email = this.email,
    passwordHash = this.password_hash,
    bio = this.bio,
    profileImage = this.profile_image
)

