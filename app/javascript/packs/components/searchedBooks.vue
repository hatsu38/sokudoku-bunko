<template>
  <section class="section">
    <div class="container">
      <article class="message is-success" v-if="keyword">
        <div class="message-body">
          <strong>{{keyword}}</strong> の検索結果：{{ books.length }}件
        </div>
      </article>
      <div class="columns is-mobile is-multiline">
        <div v-for='book in books' :key='book.id' class='column is-4-mobile is-3-tablet is-2-desktop'>
          <div class="card">
            <div class="card-image light-border-bottom">
              <figure class="image is-relative" v-if="book.rakuten_book_info">
                <img :src=book.rakuten_book_info.medium_image_url :alt="book.title">
                <p class="is-absolute impression" v-if="book.impressions_count > 0"><i class="far fa-eye"></i><span>{{ book.impressions_count }}</span></p>
              </figure>
              <figure class="image is-relative" v-else>
                <img src="/no_image.png" alt="no-image">
                <p class="is-absolute impression" v-if="book.impressions_count > 0"><i class="far fa-eye"></i><span>{{ book.impressions_count }}</span></p>
              </figure>
            </div>
            <a :href="'/books/'+book.title" class="content book-info">
              <div class="book-title">
                {{ book.title }}
              </div>
              <div class="has-text-grey-light book-author">
                <p>{{ book.author.name }}</p>
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
  data() {
    return {
      books: [],
    }
  },
  created() {
    this.fetchBooks();
  },
  watch: {
    keyword() {
      this.fetchBooks();
    }
  },
  methods: {
    fetchBooks() {
      axios.get(`/api/search?title=${this.keyword}`).then((response) => {
        this.books = response.data.books
      }, (error) => {
        console.log(error);
      });
    }
  }
}
</script>
