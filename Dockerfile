FROM  maven:3.8.5-openjdk-18  AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean install -DskipTests

FROM openjdk:23-ea-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/demotask-0.0.1-SNAPSHOT.jar  /app/demotask-0.0.1-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/demotask-0.0.1-SNAPSHOT.jar"]
