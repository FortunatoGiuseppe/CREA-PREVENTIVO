# Usa l'immagine di Maven per Java 18 come base
FROM maven:latest AS builder

# Imposta il working directory nell'immagine
WORKDIR /app

# Copia il file pom.xml nella directory corrente
COPY pom.xml .

# Esegui l'installazione delle dipendenze di Maven e installa il POM parent nel repository locale
RUN mvn clean install

# Copia tutto il codice sorgente nella directory corrente
COPY src ./src

# Esegui il build dell'applicazione usando Maven
RUN mvn package -DskipTests

# Stage finale: Crea l'immagine Docker finale con l'applicazione Java
FROM openjdk:18-jdk-slim

# Copia il file JAR dell'applicazione Java dal primo stage
COPY --from=builder /app/target/CREA-PREVENTIVO-RS-0.0.1-SNAPSHOT.jar /app/app.jar

# Espone la porta su cui l'applicazione sarà in ascolto (se necessario)
EXPOSE 8080

# Comando di avvio dell'applicazione
CMD ["java", "-jar", "/app/app.jar"]

USER 10001
