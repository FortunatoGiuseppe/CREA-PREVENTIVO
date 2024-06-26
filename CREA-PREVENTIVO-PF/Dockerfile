# Usa l'immagine di Node.js 14 come base per il build del frontend
FROM node:14 AS frontend-builder

# Imposta il working directory per il frontend
WORKDIR /app

# Copia i file necessari per il build del frontend
COPY CREA-PREVENTIVO-PF/package.json CREA-PREVENTIVO-PF/package-lock.json ./

# Esegui l'installazione delle dipendenze
RUN npm install

# Copia tutto il codice frontend nella directory corrente
COPY CREA-PREVENTIVO-PF .

# Esegui il build del frontend Angular per produzione
RUN npm run build --prod

# Stage finale: Crea l'immagine Docker finale con il frontend Angular
FROM nginx:alpine

# Copia i file statici del frontend compilato nella directory di default di Nginx
COPY --from=frontend-builder /app/dist/CREA-PREVENTIVO-PF /usr/share/nginx/html

# Copia la configurazione di Nginx
COPY CREA-PREVENTIVO-PF/nginx.conf /etc/nginx/nginx.conf

# Espone la porta 80 per il web server Nginx
EXPOSE 80

# Il comando di avvio di Nginx è gestito dall'immagine di base di Nginx automaticamente
