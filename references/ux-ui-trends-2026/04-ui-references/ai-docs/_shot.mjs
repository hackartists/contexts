import { chromium } from '/Users/hackartist/data/devel/github.com/biyard/dataroom/playwright/node_modules/playwright/index.mjs';
const [,, url, out, mode='full', sel=''] = process.argv;
const b = await chromium.launch();
const ctx = await b.newContext({
  viewport: { width: 1440, height: 900 },
  userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
  deviceScaleFactor: 2,
});
const p = await ctx.newPage();
try {
  await p.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
} catch(e) { console.error('goto:', e.message); }
await p.waitForTimeout(4000);
// dismiss cookie banners
const labels = ['Accept All','Accept all','Accept','Allow all','I agree','Got it','Reject Non-Essential','Accept Cookies','Agree'];
for (const l of labels) {
  try { const btn = p.getByRole('button', { name: l, exact: false }).first();
    if (await btn.isVisible({timeout:600})) { await btn.click({timeout:2000}); await p.waitForTimeout(800); break; } } catch(e){}
}
// scroll to trigger lazy content
const h = await p.evaluate(() => document.body.scrollHeight);
for (let y = 0; y < h; y += 700) { await p.evaluate(y => window.scrollTo(0,y), y); await p.waitForTimeout(220); }
let offset = 0;
if (mode.startsWith('scroll:')) offset = parseInt(mode.split(':')[1],10);
await p.evaluate(y => window.scrollTo(0,y), offset);
await p.waitForTimeout(3000);
try {
  if (sel) { await p.locator(sel).first().screenshot({ path: out }); }
  else await p.screenshot({ path: out, fullPage: mode === 'full' });
} catch(e) { console.error('shot:', e.message); await p.screenshot({ path: out }); }
console.log('ok', out);
await b.close();
