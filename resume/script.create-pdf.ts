import playwright from 'playwright'
import path from 'node:path'

const TMP_DIR = path.resolve(__dirname, '..', '.tmp', 'resume')
const PUBLIC_DIR = path.resolve(__dirname, '..', 'public')

;(async () => {
  const browser = await playwright.chromium.launch()
  const context = await browser.newContext(playwright.devices['Desktop Chrome'])
  const page = await context.newPage()
  const pdfPath = path.resolve(PUBLIC_DIR, 'daniel-young-résumé.pdf')

  await page.goto(`file://${ path.resolve(TMP_DIR, 'index.html') }`)
  await page.pdf({
    path: pdfPath,
    format: 'A4',
  })

  console.log(`✓ exported ${pdfPath}`)

  await context.close()
  await browser.close()
})()
