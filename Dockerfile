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
COPY CREA-PREVENTIVO/pom.xml ./pom.xml  # Copia il parent POM nella root della directory backend
COPY CREA-PREVENTIVO-RS/pom.xml ./CREA-PREVENTIVO-RS/pom.xml
COPY CREA-PREVENTIVO-PF/pom.xml ./CREA-PREVENTIVO-PF/pom.xml
COPY CREA-PREVENTIVO-RS/ ./CREA-PREVENTIVO-RS
COPY CREA-PREVENTIVO-PF/ ./CREA-PREVENTIVO-PF
RUN mvn clean package -DskipTests

# Crea l'immagine finale
FROM nginx:alpine

# Copia i file del frontend
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html

# Copia il JAR del backend
COPY --from=backend-build /app/backend/target/*.jar /app/backend.jar

# Configura Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Creare un utente non-root con UID tra 10000 e 20000 e un gruppo
RUN addgroup -g 10001 appgroup && adduser -u 10001 -G appgroup -S appuser

# Modifica le directory per appartenere all'utente non-root
RUN chown -R appuser:appgroup /app /usr/share/nginx/html

# Espone la porta 80 per il frontend
EXPOSE 80

# Utilizzare l'utente non-root per eseguire il container
USER 10001

# Comando per avviare Nginx e il backend
CMD ["sh", "-c", "nginx -g 'daemon off;' & java -jar /app/backend.jar"]
