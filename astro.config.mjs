import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';
import { copyFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';

export default defineConfig({
  site: 'https://gradetoolkit.com',
  trailingSlash: 'always',
  integrations: [
    sitemap(),
    {
      name: 'sitemap-xml-alias',
      hooks: {
        'astro:build:done': async ({ dir, logger }) => {
          await copyFile(new URL('sitemap-index.xml', dir), new URL('sitemap.xml', dir));
          logger.info('Created sitemap.xml alias for sitemap-index.xml');
        },
      },
    },
  ],
  vite: {
    resolve: {
      alias: {
        'astro/entrypoints/prerender': fileURLToPath(
          new URL('./node_modules/astro/dist/entrypoints/prerender.js', import.meta.url),
        ),
      },
    },
  },
});
