<template>
  <div>
    <nav class="is-fixed-top light-border-bottom is-flex">
      <div class="control has-icons-left has-icons-right is-flex is-fluid container field">
        <input v-model="keyword" type="text" id="bookTitleField" class="input is-success small_margin navbar_left" placeholder="著書名" />
        <span class="icon is-small is-left small_margin">
          <i class="fas fa-book" />
        </span>
        <a href="/" id="close-form" class="is-inline-block has-text-centered navbar_right header-line-hight" aria-label='トップページへ遷移する' >
          <i class="fas fa-times" />
        </a>
      </div>
    </nav>
    <div class="hero-body container">
      <p class="has-text-weight-bold has-text-center-pc">
        そくどく文庫は、本を読むのが遅い人でも楽に本を読む速度が早くなるサイトです📖
      </p>
    </div>
    <searchedBooks :keyword="keyword" />
  </div>
</template>
<script>
import searchedBooks from './searchedBooks'
export default {
  data() {
    return {
      keyword: ''
    }
  },
  components: {
    searchedBooks
  }
}
</script>
