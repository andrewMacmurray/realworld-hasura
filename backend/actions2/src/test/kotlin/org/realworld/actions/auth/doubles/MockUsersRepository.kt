package org.realworld.actions.auth.doubles

import org.realworld.actions.auth.User
import org.realworld.actions.auth.service.UsersError
import org.realworld.actions.auth.service.UsersRepository
import org.realworld.actions.utils.Result

class MockUsersRepository : UsersRepository {
    private var nextId: Int = 0
    var users: List<User> = emptyList()

    override fun create(user: User.ToCreate): Result<UsersError, User> {
        val newUser = newUser(user, nextId)
        incrementId()
        storeUser(newUser)
        return Result.Ok(newUser)
    }

    private fun storeUser(newUser: User) {
        users = users + newUser
    }

    private fun incrementId() {
        nextId += 1
    }

    fun reset() {
        nextId = 0
        users = emptyList()
    }

    private fun newUser(user: User.ToCreate, id: Int) =
        User(
            id = id,
            username = user.username,
            email = user.email,
            passwordHash = user.passwordHash,
            profileImage = null,
            bio = null
        )
}