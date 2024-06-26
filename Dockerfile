# Fase di build del backend
FROM maven:3.8.5-openjdk-18 AS backend-build
WORKDIR /app/backend
COPY pom.xml .
COPY CREA-PREVENTIVO-RS/ ./CREA-PREVENTIVO-RS
COPY CREA-PREVENTIVO-PF/ ./CREA-PREVENTIVO-PF
RUN mvn clean package -DskipTests

# Fase di build del frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY CREA-PREVENTIVO-PF/ .
RUN npm install
RUN npm run build

# Fase finale
FROM openjdk:18-jdk-alpine
WORKDIR /app

# Creazione di un utente non-root e impostazione dei permessi
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copia dei file dalla fase di build del backend
COPY --from=backend-build /app/backend/target/backend.jar ./backend.jar

# Copia dei file dalla fase di build del frontend
COPY --from=frontend-build /app/frontend/build ./frontend

# Impostazione dei permessi per l'utente non-root
RUN chown -R appuser:appgroup /app

# Passaggio all'utente non-root
USER appuser

# Esporre la porta 8080
EXPOSE 8080

# Comando di avvio dell'applicazione
CMD ["java", "-jar", "backend.jar"]
