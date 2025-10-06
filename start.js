const express = require('express');
const puppeteer = require('puppeteer');
const app = express();

app.get('/scrape', async (req, res) => {
  const { url, key } = req.query;
  if (key !== process.env.API_KEY) return res.status(403).send('Forbidden');

  try {
    const browser = await puppeteer.launch({
      headless: 'new',
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    const page = await browser.newPage();
    await page.goto(url, { waitUntil: 'networkidle0' });
    await new Promise(resolve => setTimeout(resolve, 5000));

    const textoPlano = await page.evaluate(() => document.body.innerText);

    const rasgos = [];
    const regex = /([A-Za-zÁÉÍÓÚáéíóúÑñ]+):\s+(\d+)%\s+([A-Za-zÁÉÍÓÚáéíóúÑñ]+)/g;
    let match;

    while ((match = regex.exec(textoPlano)) !== null) {
      rasgos.push({
        categoria: match[1],
        porcentaje: match[2] + '%',
        tipo: match[3]
      });
    }

    await browser.close();
    res.json({ rasgos });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(process.env.PORT || 3000, () => {
  console.log('Scraper microservice running');
});