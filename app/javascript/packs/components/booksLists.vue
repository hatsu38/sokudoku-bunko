<template>
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
        <a :href="'/books/'+book.title" class="content book-info is-size-7">
          <div class="book-title">
            {{ book.title }}
          </div>
          <div class="has-text-grey-light book-author">
            <p>{{ book.author.name }}</p>
          </div>
        </a>
      </div>
    </div>
    <infinite-loading spinner="waveDots" @infinite="infiniteHandler">
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
  data() {
    return {
      books: [],
      page: 1
    }
  },
  methods: {
    async infiniteHandler($state) {
      await axios.get(`${this.path}?&page=${this.page}`).then((response) => {
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
