<template>
  <div class="columns is-mobile is-multiline">
    <div v-for="(book, idx) in books" class="column is-6-mobile is-3-tablet is-2-desktop">
      <div class="card">
        <div class="card-image light-border-bottom">
          <figure class="image" v-if="book.rakuten_book_info">
            <img :src=book.rakuten_book_info.medium_image_url>
          </figure>
          <figure class="image" v-else>
            <img src="/no_image.png">
          </figure>
        </div>
        <a :href="'/books/'+book.title" class="content book-info">
          <div class="book-title">
            {{ book.title }}
          </div>
        </a>
      </div>
    </div>
    <infinite-loading spinner="waveDots" @infinite="infiniteHandler" :distance="500">
      <!-- slotでメッセージをカスタマイズできる -->
      <div slot="no-more"></div>
      <div slot="no-results"></div>
    </infinite-loading>
  </div>
</template>

<script>
import axios from 'axios'
import InfiniteLoading from "vue-infinite-loading";

export default {
  props: ['path'],
  components: {
    InfiniteLoading
  },
  data: function () {
    return {
      books: [],
      page: 1
    }
  },
  created: function(){
    this.fetchBooks()
  },
  methods: {
    fetchBooks: function () {
      axios.get(`/api/search?title=${this.keyword}`).then((response) => {
        this.books = response.data.books
      }, (error) => {
        console.log(error);
      });
    },
    infiniteHandler($state) {
      console.log($state)
      axios.get(`${this.path}?&page=${this.page}`).then((response) => {
        console.log(response)
        if(response.data.books.length > 0) {
          this.books.push(...response.data.books)
          this.page++
          $state.loaded()
        } else {
          $state.complete();
        }
      }, (error) => {
        console.log(error);
        $state.complete();
      });
    },
  },
}
</script>

<style>
.infinite-loading-container{
  width: 100%;
  margin: 1rem auto 2rem;
}
.card-image > .image > img{
  height: 231px;
}

.book-title{
  padding: 5px 4px;
  height: 54px;
}
.message-body{
  padding: 10px;
  margin-top: -1rem;
}
</style>
