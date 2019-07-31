import Vue from 'vue/dist/vue.esm'
import search from './components/search.vue'

var app = new Vue({
  el: '#searchPage',
  components: {
    'search': search
  }
});
