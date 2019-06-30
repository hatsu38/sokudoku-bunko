<template>
<div>
  <h3>そくどく！٩( 'ω' )و</h3>
  <ul>
    <li v-for="word in words">
      {{word.text}}
    </li>
  </ul>
</div>
</template>
<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      words: []
    }
  },
  mounted: function () {
    this.fetchTasks();
  },
  methods: {
    fetchTasks: function () {
      axios.get('/api/books/1').then((response) => {
        console.log(response);
        this.words = response.data.words
      }, (error) => {
        console.log(error);
      });
    },
  }
}
</script>

<style>
</style>
