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
COPY --from=backend-build /app/backend/target/backend.jar ./backend.jar
COPY --from=frontend-build /app/frontend/build ./frontend
EXPOSE 8080
CMD ["java", "-jar", "backend.jar"]
