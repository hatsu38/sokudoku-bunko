import Vue from 'vue/dist/vue.esm'
import sokudoku from './components/sokudoku.vue'

var app = new Vue({
  el: '#words',
  components: {
    sokudoku
  }
});
