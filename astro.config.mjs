import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://student-performance-toolkit-v1.vercel.app',
  integrations: [sitemap()],
});