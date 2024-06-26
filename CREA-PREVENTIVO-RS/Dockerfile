# Usa l'immagine base di OpenJDK per Java 18
FROM openjdk:18-jdk-slim AS backend

# Copia il jar del backend nella directory /app
COPY CREA-PREVENTIVO-RS/target/CREA-PREVENTIVO-RS-0.0.1-SNAPSHOT.jar /app/CREA-PREVENTIVO-RS.jar

# Porta su cui il backend sarà esposto (assumendo che il backend ascolti sulla porta 8080)
EXPOSE 8080

# USER
USER 10014

# Comando di avvio del backend
CMD ["java", "-jar", "/app/CREA-PREVENTIVO-RS.jar"]
