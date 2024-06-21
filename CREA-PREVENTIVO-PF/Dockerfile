# Usa l'immagine Node per costruire l'app
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Usa un'immagine Nginx per servire l'app
FROM nginx:alpine
COPY --from=build /app/dist/angular /usr/share/nginx/html
EXPOSE 80
