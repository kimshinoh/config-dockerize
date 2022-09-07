<template>
  <div id="app">
    <v-app>
      <v-content v-if="loggedIn===null">
        <v-container fill-height>
          <v-layout align-center justify-center>
            <v-flex>
              <div class="text-xs-center">
                <div class="headline my-5">Loading...</div>
                <v-progress-circular size="100" indeterminate color="primary"></v-progress-circular>
              </div>
            </v-flex>
          </v-layout>
        </v-container>
      </v-content>
      <router-view v-else />
      <NotificationsManager></NotificationsManager>
    </v-app>
  </div>
</template>

<script lang="js">
import NotificationsManager from '@/components/NotificationsManager.vue';
import { readIsLoggedIn } from '@/store/main/getters';
import { dispatchCheckLoggedIn } from '@/store/main/actions';

export default {
  name: 'App',
  components: {
    NotificationsManager,
  },
  computed: {
    loggedIn() {
      return readIsLoggedIn(this.$store);
    },
  },
  created() {
    dispatchCheckLoggedIn(this.$store);
  },
};

</script>
