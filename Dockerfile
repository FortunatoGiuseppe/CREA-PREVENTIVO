# Stage 1: Build del frontend Angular
FROM node:latest AS frontend-builder

# Imposta il working directory dell'applicazione frontend
WORKDIR /app/frontend

# Copia il file package.json e package-lock.json nella directory corrente
COPY CREA-PREVENTIVO-PF/package*.json ./

# Installa le dipendenze
RUN npm install

# Copia il resto del codice dell'applicazione
COPY CREA-PREVENTIVO-PF .

# Compila l'applicazione Angular per produzione
RUN npm run build --prod


# Stage 2: Build e esecuzione del backend Spring Boot
FROM openjdk:18-jdk-slim AS backend-builder

# Imposta il working directory del backend
WORKDIR /app/backend

# Copia il codice sorgente del backend
COPY CREA-PREVENTIVO-RS /app/backend

# Compila il backend Spring Boot
RUN ./mvnw package -DskipTests

# Stage finale: Utilizza l'immagine di OpenJDK per eseguire il backend e serve il frontend compilato
FROM openjdk:18-jdk-slim

# Imposta il working directory per il backend
WORKDIR /app

# Copia il jar compilato del backend dalla stage precedente
COPY --from=backend-builder /app/backend/target/CREA-PREVENTIVO-RS.jar .

# Copia i file statici compilati del frontend dalla stage del frontend-builder nella directory di default di Spring Boot
COPY --from=frontend-builder /app/frontend/dist/CREA-PREVENTIVO-PF /app/src/main/resources/static

# Esponi la porta 8080 per il backend Spring Boot
EXPOSE 8080

# Comando di avvio del backend Spring Boot
CMD ["java", "-jar", "CREA-PREVENTIVO-RS.jar"]
