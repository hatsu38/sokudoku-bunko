<template>
  <section class="section">
    <div class="container">
      <h2 class="subtitle has-text-weight-bold section-title">小説一覧</h2>
      <div v-for='author in authors' :key='author.id + author.name' class="author-block">
        <div v-if="author.books">
          <h3 class="author-name has-text-weight-bold push-bottom">{{ author.name }}</h3>
          <div class='columns is-mobile is-multiline'>
            <div v-for='book in author.books' :key="book.id" class='column is-6-mobile is-3-tablet is-2-desktop'>
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
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <infinite-loading spinner='waveDots' @infinite='infiniteHandler'>
        <!-- slotでメッセージをカスタマイズできる -->
        <div slot='no-more'></div>
        <div slot='no-results'></div>
      </infinite-loading>
    </div>
  </section>
</template>

<script>
import axios from 'axios'
import InfiniteLoading from "vue-infinite-loading";

export default {
  components: {
    InfiniteLoading
  },
  data() {
    return {
      authors: [],
      page: 1
    }
  },
  methods: {
    infiniteHandler($state) {
      axios.get(`/api/authors?&page=${this.page}`).then((response) => {
        if(response.data.authors.length > 0) {
          this.authors.push(...response.data.authors)
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
