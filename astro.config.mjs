import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://student-performance-toolkit-6hgn.vercel.app',
  integrations: [sitemap()],
});