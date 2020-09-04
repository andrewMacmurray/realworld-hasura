plugins {
    kotlin("jvm") version "1.3.72"
    application
    id("com.github.johnrengelman.shadow") version "5.2.0"
    id("com.expediagroup.graphql") version "3.6.1"
}

group = "org.realworld"
version = "1.0-SNAPSHOT"

application {
    mainClassName = "$group.actions.ApplicationKt"
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

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.http4k:http4k-core:3.247.0")
    implementation("org.http4k:http4k-format-jackson:3.247.0")
    implementation("org.http4k:http4k-serverless-lambda:3.247.0")
    implementation("io.jsonwebtoken:jjwt-jackson:0.11.2")
    runtimeOnly("io.jsonwebtoken:jjwt-impl:0.11.2")
    implementation("io.jsonwebtoken:jjwt-api:0.11.2")
    implementation("org.mindrot:jbcrypt:0.4")
    implementation("com.expediagroup:graphql-kotlin-client:3.6.1")
    implementation("org.koin:koin-core:2.1.6")

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

task<Exec>("deploy") {
    dependsOn("shadowJar")
    commandLine("sls", "deploy")
}

task("testCI") {
    tasks.getByName("graphqlIntrospectSchema").enabled = false
    dependsOn("test")
}