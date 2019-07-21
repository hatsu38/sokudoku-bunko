<template>
  <section class="section">
    <div class="container">
      <article class="message is-success" v-if="keyword">
        <div class="message-body">
          <strong>{{keyword}}</strong> の検索結果：{{ books.length }}件
        </div>
      </article>
      <div class="columns is-mobile is-multiline">
        <div v-for="(book, idx) in books" class="column is-6-mobile is-3-tablet is-2-desktop">
          <div class="card">
            <div class="card-image light-border-bottom">
              <figure class="image" v-if="book.rakuten_book_info">
                <img :src=book.rakuten_book_info.medium_image_url>
              </figure>
              <figure class="image" v-else>
                <img src="no_image.png">
              </figure>
            </div>
            <a :href="'/books/'+book.title" class="content book-info">
              <div class="book-title">
                {{ book.title }}
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import axios from 'axios'
import Router from '../router'

export default {
  props: ['keyword'],
  data: function () {
    return {
      books: [],
    }
  },
  created: function () {
    this.fetchBooks();
  },
  watch: {
    keyword: function(){
      this.fetchBooks();
    }
  },
  methods: {
    fetchBooks: function () {
      axios.get(`/api/search?title=${this.keyword}`).then((response) => {
        this.books = response.data.books
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>

<style>
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
