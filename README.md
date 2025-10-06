# 🧠 Scraper Microservice – Puppeteer + Express

Este proyecto es un microservicio Node.js que utiliza Puppeteer para extraer rasgos de personalidad desde páginas web. Está diseñado para ser desplegado en [Render](https://render.com) y consumido desde cualquier frontend o backend (por ejemplo, PHP en cPanel).

---

## 🚀 ¿Qué hace?

- Navega a una URL proporcionada.  
- Espera 5 segundos para asegurar carga completa.  
- Extrae texto plano del `<body>`.  
- Detecta patrones como: `Introversión: 85% Alto`  
- Devuelve un JSON con los rasgos encontrados.

---

## 📦 Instalación local

```bash
git clone https://github.com/tu-usuario/scraper-service.git
cd scraper-service
npm install
```

---

## 🧪 Ejecución local

```bash
API_KEY=tu_clave_secreta PORT=3000 node start.js
```

Luego accede a:  
`http://localhost:3000/scrape?url=https://ejemplo.com&key=tu_clave_secreta`

---

## 🌐 Despliegue en Render

1. Crea una cuenta en [Render](https://render.com).  
2. Elige **"New Web Service"**.  
3. Conecta tu repositorio.  
4. Configura:
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Environment Variables**:
     - `API_KEY`: tu clave secreta
     - `PORT`: Render lo asigna automáticamente

---

## 🔐 Seguridad

Este microservicio requiere una clave (`API_KEY`) para acceder. Asegúrate de mantenerla privada y no exponerla en el frontend.

---

## 📥 Ejemplo de respuesta

```json
{
  "rasgos": [
    {
      "categoria": "Introversión",
      "porcentaje": "85%",
      "tipo": "Alto"
    },
    {
      "categoria": "Empatía",
      "porcentaje": "72%",
      "tipo": "Moderado"
    }
  ]
}
```

---

## 🧩 Consumo desde PHP

```php
$url = "https://tu-render-url.onrender.com/scrape?url=https://test.com&key=tu_clave_secreta";
$response = file_get_contents($url);
$data = json_decode($response, true);

foreach ($data['rasgos'] as $rasgo) {
    echo "{$rasgo['categoria']}: {$rasgo['porcentaje']} ({$rasgo['tipo']})<br>";
}
```

---

## 🛠️ Personalización

Puedes modificar el regex en `start.js` para adaptarlo a otros formatos de resultados, o agregar nuevas rutas como `/scrape-meta`, `/scrape-tabla`, etc.