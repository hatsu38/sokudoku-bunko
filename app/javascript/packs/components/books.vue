<template>
  <section class="section">
    <div class="container">
      <h2 class="subtitle has-text-weight-bold section-title">小説一覧</h2>
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
    booksLists
  },
  created() {
    this.createPath()
  },
  methods: {
    createPath() {
      const url = location.pathname
      if( url == '/') {
        this.path = '/api/books?'
      } else if ( url.startsWith('/authors')) {
        this.path = `/api/${url}?`
      } else {
        this.path = '/api/books?'
      }
    }
  }
}
</script>

<style scoped>
.section-title{
  margin-top: 20px;
}
</style>
