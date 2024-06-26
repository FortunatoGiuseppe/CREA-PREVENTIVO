# Usa l'immagine Maven per costruire l'app
FROM maven:3.8.5-openjdk-18 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Usa l'immagine OpenJDK per eseguire l'app
FROM openjdk:18-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080

# Imposta un utente non-root per eseguire l'app (esempio: user 10014)
USER 10014

ENTRYPOINT ["java", "-jar", "app.jar"]
