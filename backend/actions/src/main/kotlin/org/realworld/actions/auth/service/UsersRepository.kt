package org.realworld.actions.auth.service

import com.expediagroup.graphql.types.GraphQLResponse
import kotlinx.coroutines.runBlocking
import org.realworld.actions.HasuraClient
import org.realworld.actions.auth.User
import org.realworld.actions.auth.UsersError
import org.realworld.actions.auth.UsersError.DuplicateUser
import org.realworld.actions.auth.service.Mappers.toNewUser
import org.realworld.actions.auth.service.Mappers.toUser
import org.realworld.actions.auth.service.Mappers.variables
import org.realworld.actions.utils.Result
import org.realworld.actions.utils.Result.Ok
import org.realworld.actions.utils.pipe
import org.realworld.generated.CreateUserMutation
import org.realworld.generated.FindUserQuery

interface UsersRepository {
    fun create(user: User.ToCreate): Result<UsersError, User>
    fun find(username: String): User?
}

class HasuraUsers(private val client: HasuraClient) : UsersRepository {

    override fun create(user: User.ToCreate): Result<UsersError, User> = runBlocking {
        user.variables()
            .pipe { createMutation(it) }
            .pipe(::toNewUser)
    }

    private suspend fun createMutation(it: CreateUserMutation.Variables) = try {
        CreateUserMutation(client).execute(it)
    } catch (e: Exception) {
        throw Exception("creating went wrong $e")
    }

    override fun find(username: String): User? = runBlocking {
        FindUserQuery.Variables(username)
            .pipe { FindUserQuery(client).execute(it) }
            .pipe(::toFoundUser)
    }

    private fun toNewUser(response: GraphQLResponse<CreateUserMutation.Result>): Result<UsersError, User> =
        if (response.hasDuplicateUserError) {
            Result.Err(DuplicateUser)
        } else {
            response.data!!
                .create_user!!
                .toNewUser()
                .pipe(::Ok)
        }

    private val GraphQLResponse<CreateUserMutation.Result>.hasDuplicateUserError
        get() = this.errors?.any { it.message.contains("Uniqueness violation") } == true

    private fun toFoundUser(response: GraphQLResponse<FindUserQuery.Result>): User? =
        response.data
            ?.users
            ?.get(0)
            ?.toUser()
}

private object Mappers {
    fun User.ToCreate.variables() =
        CreateUserMutation.Variables(
            username = username,
            email = email,
            password_hash = passwordHash
        )

    fun FindUserQuery.users.toUser() = User(
        id = id,
        username = username,
        email = email,
        passwordHash = password_hash,
        profileImage = profile_image,
        bio = bio
    )

    fun CreateUserMutation.users.toNewUser() = User(
        id = id,
        username = username,
        email = email,
        passwordHash = password_hash,
        bio = bio,
        profileImage = profile_image
    )
}