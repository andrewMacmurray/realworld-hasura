# Realworld Actions Server

Http server for hasura actions built using Kotlin + Http4k

## Get up and running

### With Intellij

- Make sure .env.local file is loaded into run configuration (I use the `.env files support` plugin)
- Press play button in `Application.kt` -> `main` to start the server
- Run tests with `CMD + SHIFT + R` when highlighting the test folder

### With Gradle

- Run the server with `set -o allexport && source .env.local && ./gradlew run`
- Run the tests with `./gradlew test`
