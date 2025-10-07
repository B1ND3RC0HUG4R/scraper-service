# Usa una imagen oficial de Node.js
FROM node:20

# Crea el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Evita que Puppeteer descargue Chromium automáticamente
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Instala dependencias
RUN npm install

# Expone el puerto (Railway lo asigna automáticamente)
EXPOSE 3000

# Comando de inicio
CMD ["node", "start.js"]