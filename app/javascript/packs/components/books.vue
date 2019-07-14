<template>
  <section class="section">
    <div class="container">
      <booksLists :path="path" />
    </div>
  </section>
</template>

<script>
import booksLists from './booksLists'
export default {
  data() {
    return {
      path: ''
    }
  },
  components: {
    'booksLists': booksLists
  },
  created() {
    this.createPath()
  },
  methods: {
    createPath() {
      const url = location.pathname
      if( url == '/') {
        this.path = '/api/books/?'
      } else if ( url.startsWith('/authors')) {
        this.path = `/api/${url}?`
      } else {
        this.path = `/api/${url}?`
      }
    }
  }
}
</script>
