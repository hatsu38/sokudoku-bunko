import Vue from 'vue/dist/vue.esm'
import books from './components/books.vue'

var app = new Vue({
  el: '#books',
  components: {
    'books': books,
  }
});
