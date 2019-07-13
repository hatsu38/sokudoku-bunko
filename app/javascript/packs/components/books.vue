<template>
  <section class="section">
    <div class="container">
      <div class="columns is-mobile is-multiline">
        <div v-for="(book, idx) in books" class="column is-half">
          <div class="card">
            <div class="card-image light-border-bottom">
              <figure class="image" v-if="book.rakuten_book_info">
                <img :src=book.rakuten_book_info.medium_image_url>
              </figure>
              <figure class="image" v-else>
                <img src="no_image.png">
              </figure>
            </div>
            <a :href="'/books/'+book.id" class="content book-info">
              <div class="book-title">
                {{ book.title }}
              </div>
            </a>
          </div>
        </div>
        <infinite-loading @infinite="infiniteHandler">
          <!-- slotでメッセージをカスタマイズできる -->
          <div slot="no-more"></div>
          <div slot="no-results"></div>
        </infinite-loading>
      </div>
    </div>
  </section>
</template>

<script>
import axios from 'axios'
import Router from '../router'
import InfiniteLoading from "vue-infinite-loading";

export default {
  components: {
    InfiniteLoading
  },
  data: function () {
    return {
      books: [],
      page: 1,
    }
  },
  created() {
    this.fetchBooks();
  },
  methods: {
    fetchBooks() {
      axios.get(`/api/books?page=${this.page}`).then((response) => {
        this.books.push(...response.data.books)
        this.page++
      }, (error) => {
        console.log(error);
      });
    },
    async infiniteHandler($state) {
      await axios.get(`/api/books?page=${this.page}`).then((response) => {
        if(response.data.books.length) {
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
