const { chromium } = require('playwright');

(async () => {
  // Output file (webm) recorded by Playwright
  const videoDir = 'out-video';
  const browser = await chromium.launch({
    headless: true,
    args: [
      '--no-sandbox',
      '--disable-dev-shm-usage'
    ]
  });

  const context = await browser.newContext({
    viewport: { width: 1920, height: 1080 },
    recordVideo: { dir: videoDir, size: { width: 1920, height: 1080 } },
    userAgent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120 Safari/537.36'
  });

  const page = await context.newPage();

  // Helper: slow scroll for b-roll
  async function slowScroll(px = 1200, steps = 6) {
    for (let i = 0; i < steps; i++) {
      await page.mouse.wheel(0, Math.floor(px / steps));
      await page.waitForTimeout(500);
    }
  }

  // Try to keep everything deterministic.
  page.setDefaultTimeout(30000);

  // 1) Homepage
  await page.goto('https://www.a8ads.com/', { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1500);
  await slowScroll(800, 4);
  await page.waitForTimeout(800);

  // If not logged in, we can only capture public marketing / some pages.
  // 2) Ads library (may redirect to login)
  await page.goto('https://www.a8ads.com/ads', { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1500);
  await slowScroll(1200, 6);
  await page.waitForTimeout(800);

  // 3) Advertisers
  await page.goto('https://www.a8ads.com/advertisers', { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1500);
  await slowScroll(1200, 6);
  await page.waitForTimeout(800);

  // 4) Products
  await page.goto('https://www.a8ads.com/products', { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1500);
  await slowScroll(1200, 6);
  await page.waitForTimeout(800);

  // End
  await page.waitForTimeout(1500);

  await context.close();
  await browser.close();

  console.log('Done. Video saved under:', videoDir);
})();
