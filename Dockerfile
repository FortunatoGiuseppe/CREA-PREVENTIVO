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

# Crea l'immagine finale con Nginx per il frontend e il JAR del backend
FROM nginx:alpine AS final
# Copia i file del frontend
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html
# Copia il JAR del backend
COPY --from=backend-build /app/backend/target/*.jar /app/backend.jar

# Configura Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Espone la porta 80 per il frontend e la porta 8080 per il backend
EXPOSE 80 8080

# Comando per avviare entrambi i server
CMD ["sh", "-c", "nginx -g 'daemon off;' & java -jar /app/backend.jar"]
