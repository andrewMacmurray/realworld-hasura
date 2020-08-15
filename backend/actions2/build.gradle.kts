plugins {
    kotlin("jvm") version "1.3.72"
    id("com.github.johnrengelman.shadow") version "5.2.0"
    id("com.expediagroup.graphql") version "3.6.1"
}

group = "org.realworld"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

graphql {
    client {
        endpoint = "http://localhost:8080/v1/graphql"
        packageName = "org.realworld.generated"
        headers["X-Hasura-Admin-Secret"] = "ilovebread"
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.http4k:http4k-core:3.247.0")
    implementation("org.http4k:http4k-format-jackson:3.247.0")
    implementation("org.http4k:http4k-serverless-lambda:3.247.0")
    implementation("com.auth0:java-jwt:3.9.0")
    implementation("org.mindrot:jbcrypt:0.4")
    implementation("com.expediagroup:graphql-kotlin-client:3.6.1")

    testImplementation("org.junit.jupiter:junit-jupiter:5.6.2")
    testImplementation("org.http4k:http4k-testing-hamkrest:3.247.0")
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

val deploy = task<Exec>("deploy") {
    dependsOn("shadowJar")
    commandLine("sls", "deploy")
}