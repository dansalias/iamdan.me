import { defineConfig } from 'vite'
import { viteSingleFile } from 'vite-plugin-singlefile'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  base: './',
  build: {
    outDir: '../.tmp/resume',
    emptyOutDir: true,
  },
  plugins: [vue(), viteSingleFile()],
})
