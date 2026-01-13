### Install `vite-plugin-html` and `vite-plugin-vue-devtools`

```
npm install vite-plugin-html
npm install vite-plugin-vue-devtools
```

### Add this to `vite.config.js`

```
import { createHtmlPlugin } from 'vite-plugin-html'
import vueDevTools from 'vite-plugin-vue-devtools'

export default defineConfig({
  plugins: [
    // register vueDevTools before createHtmlPlugin
    vueDevTools(),
    createHtmlPlugin({})
  ]
})
```

### Install VueJs Devtools addon to the browser

### Good to go!
