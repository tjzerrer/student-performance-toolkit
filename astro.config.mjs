import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://student-performance-toolkit-app.vercel.app',
  integrations: [sitemap()],
});