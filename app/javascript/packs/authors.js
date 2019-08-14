import Vue from 'vue/dist/vue.esm'
import authors from './components/authors.vue'

var app = new Vue({
  el: '#authors',
  components: {
    authors,
  }
});
