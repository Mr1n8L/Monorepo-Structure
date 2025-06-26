# Multi-stage build for Java application
FROM gradle:8.5-jdk21 AS build

# Set working directory
WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle/ gradle/
COPY build.gradle .
COPY settings.gradle .
COPY buildSrc/ buildSrc/

# Copy source code for all subprojects
COPY lib/ lib/
COPY shared/ shared/
COPY subproject-1/ subproject-1/
COPY subproject-2/ subproject-2/
COPY subproject-3/ subproject-3/

# Build the application
RUN ./gradlew :subproject-3:build --no-daemon

# Runtime stage
FROM openjdk:21-jre-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/subproject-3/build/libs/*.jar app.jar

# Expose port (optional, if your app serves HTTP)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-cp", "app.jar", "subproject.App"] 