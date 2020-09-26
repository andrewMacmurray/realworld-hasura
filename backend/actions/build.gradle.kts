plugins {
    kotlin("jvm") version "1.3.72"
    id("application")
    id("com.github.johnrengelman.shadow") version "6.0.0"
    id("com.expediagroup.graphql") version "4.0.0-alpha.4"
}

group = "org.realworld"
version = "1.0.0"

application {
    mainClassName = "$group.actions.ApplicationKt"
}

tasks.shadowJar {
    mergeServiceFiles()
}

repositories {
    jcenter()
    mavenCentral()
}

graphql {
    client {
        endpoint = "http://localhost:8080/v1/graphql"
        packageName = "$group.generated"
        headers["X-Hasura-Admin-Secret"] = "ilovebread"
    }
}

val log4jVersion = "2.12.1"
val http4kVersion = "3.247.0"
val graphqlVersion = "4.0.0-alpha.4"
val ktorVersion = "1.3.1"

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.http4k:http4k-core:$http4kVersion")
    implementation("org.http4k:http4k-format-jackson:$http4kVersion")
    implementation("org.http4k:http4k-serverless-lambda:$http4kVersion")
    implementation("org.http4k:http4k-server-jetty:$http4kVersion")
    implementation("io.jsonwebtoken:jjwt-jackson:0.11.2")
    runtimeOnly("io.jsonwebtoken:jjwt-impl:0.11.2")
    implementation("io.jsonwebtoken:jjwt-api:0.11.2")
    implementation("org.mindrot:jbcrypt:0.4")
    implementation("com.expediagroup:graphql-kotlin-ktor-client:$graphqlVersion")
    implementation("com.expediagroup:graphql-kotlin-client:$graphqlVersion")
    implementation("io.ktor:ktor-client-okhttp:$ktorVersion")
    implementation("io.ktor:ktor-client-logging-jvm:$ktorVersion")
    implementation("org.koin:koin-core:2.1.6")
    implementation("org.apache.logging.log4j:log4j-slf4j-impl:$log4jVersion")
    testImplementation("org.junit.jupiter:junit-jupiter:5.6.2")
}

tasks {
    compileKotlin {
        kotlinOptions.jvmTarget = "1.8"
        kotlinOptions.freeCompilerArgs += "-Xopt-in=io.ktor.util.KtorExperimentalAPI"
    }
    compileTestKotlin {
        kotlinOptions.jvmTarget = "1.8"
    }
}

tasks.graphqlIntrospectSchema {
    enabled = !isRemoteEnv()
}

fun isRemoteEnv(): Boolean =
    System.getenv("CI") == "true"

