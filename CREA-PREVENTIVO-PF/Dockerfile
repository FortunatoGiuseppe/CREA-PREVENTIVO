# Usa l'immagine base di Node.js per compilare l'applicazione Angular
FROM node:latest AS frontend

# Imposta il working directory dell'applicazione frontend
WORKDIR /app

# Copia il file package.json nella directory corrente
COPY CREA-PREVENTIVO-PF/package.json .

# Installa le dipendenze
RUN npm install

# Copia il resto del codice dell'applicazione
COPY CREA-PREVENTIVO-PF .

# Compila l'applicazione
RUN npm run build --prod

# Stage finale: usa l'immagine Nginx per servire l'applicazione compilata
FROM nginx:latest

# Copia i file statici compilati dallo stage precedente nella directory di default di Nginx
COPY --from=frontend /app/dist/CREA-PREVENTIVO-PF /usr/share/nginx/html

# Esponi la porta 80 per il server Nginx
EXPOSE 80

# Non è necessario specificare un CMD esplicito, l'immagine Nginx ha un CMD di default per avviare il server
