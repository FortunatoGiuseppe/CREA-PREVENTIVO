# Fase di build del frontend
FROM node:18 AS frontend-build
WORKDIR /app/frontend
COPY CREA-PREVENTIVO-PF/package*.json ./
RUN npm install
COPY CREA-PREVENTIVO-PF/ ./
RUN npm run build --prod

# Fase di build del backend
FROM maven:3.8.5-openjdk-18 AS backend-build
WORKDIR /app/backend
COPY pom.xml .
COPY CREA-PREVENTIVO-RS/ ./src
RUN mvn clean package -DskipTests

# Crea l'immagine finale
FROM openjdk:18-jdk-alpine
# Copia il JAR del backend
COPY --from=backend-build /app/backend/target/*.jar /app/backend.jar
# Copia i file del frontend
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html

# Creare un utente non-root e un gruppo
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /app /usr/share/nginx/html

# Espone la porta 8080 per il backend
EXPOSE 8080

# Utilizzare l'utente non-root per eseguire il container
USER appuser

# Comando per avviare il backend
ENTRYPOINT ["sh", "-c", "java -jar /app/backend.jar"]
