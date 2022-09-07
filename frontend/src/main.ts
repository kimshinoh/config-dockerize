import '@babel/polyfill';
// Import Component hooks before component definitions
// import './component-hooks';
import { createApp } from 'vue';
import vuetify from './plugins/vuetify';
import App from './App.vue';
import router from './router';
import store from '@/store';
import './registerServiceWorker';

const app = createApp(App)
  .use(vuetify)
  .use(router)
  .use(store);


router.isReady().then(() => {
  app.mount('#app');
});
