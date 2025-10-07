# Usa una imagen oficial de Node.js
FROM node:20

# Crea el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Evita que Puppeteer descargue Chromium automáticamente
ENV PUPPETEER_SKIP_DOWNLOAD=true

# Instala Google Chrome y dependencias necesarias
RUN apt-get update \
	&& apt-get install -y wget gnupg2 \
	&& wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update \
	&& apt-get install -y google-chrome-stable \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Configura Puppeteer para usar el Chrome instalado
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Instala dependencias
RUN npm install

# Expone el puerto (Railway lo asigna automáticamente)
EXPOSE 3000

# Comando de inicio
CMD ["node", "start.js"]