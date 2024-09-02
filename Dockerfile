#
# Build stage
#

FROM maven:3.8.4-openjdk-8 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

#
# Final stage
#

FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY --from=build /app/target/java-maven-app-1.1.0-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app

ENTRYPOINT ["java", "-jar", "java-maven-app-1.1.0-SNAPSHOT.jar"]

