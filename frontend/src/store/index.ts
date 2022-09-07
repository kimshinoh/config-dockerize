import Vue from 'vue';
import Vuex, { createStore, StoreOptions } from 'vuex';

import { mainModule } from './main';
import { State } from './state';
import { adminModule } from './admin';

const storeOptions: StoreOptions<State> = {
  modules: {
    main: mainModule,
    admin: adminModule,
  },
};


export default createStore(storeOptions);
