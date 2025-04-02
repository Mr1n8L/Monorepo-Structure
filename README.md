# Monorepo-Structure
Learning Monorepo structure for Microservices architecture 

POC for Monorepo

mr1n8l-monorepo-structure/
├── README.md
├── gradlew
├── gradlew.bat
├── buildSrc/
│   └── src/
│       └── main/
│           └── java/
├── gradle/
│   └── wrapper/
│       └── gradle-wrapper.properties
├── settings.gradle
├── build.gradle
├── project-1/
│   ├── src/main/java/com/example/project1/
│   │   ├── Project1Application.java
│   │   ├── controller/HelloController.java
│   ├── build.gradle
├── project-2/
│   ├── src/main/java/com/example/project2/
│   │   ├── Project2Application.java
│   │   ├── controller/GreetController.java
│   ├── build.gradle
└── shared/
    ├── src/main/java/com/example/shared/
    │   ├── utility/UtilityService.java
    ├── build.gradle

// settings.gradle
rootProject.name = 'mr1n8l-monorepo-structure'
include 'project-1', 'project-2', 'shared'

// build.gradle (Root)
allprojects {
    repositories {
        mavenCentral()
    }
}

subprojects {
    apply plugin: 'java'
    apply plugin: 'org.springframework.boot'
    apply plugin: 'io.spring.dependency-management'

    dependencies {
        implementation 'org.springframework.boot:spring-boot-starter-web'
    }
}

// project-1/build.gradle
dependencies {
    implementation project(':shared')
}

// project-2/build.gradle
dependencies {
    implementation project(':shared')
}

// shared/build.gradle
apply plugin: 'java-library'
