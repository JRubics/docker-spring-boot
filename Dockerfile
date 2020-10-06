FROM maven:3.6.3-jdk-11 AS build

WORKDIR /build/

COPY pom.xml ./
COPY src ./src/

RUN mvn package

FROM adoptopenjdk/openjdk11:latest

WORKDIR /app

COPY --from=build /build/target/*.jar /app/spring-boot-app.jar

ENTRYPOINT ["java", "-jar","/app/spring-boot-app.jar"]