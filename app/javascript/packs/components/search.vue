<template>
  <div>
    <nav class="is-fixed-top light-border-bottom is-flex">
      <div class="control has-icons-left has-icons-right is-flex is-fluid container field">
        <form class="small_margin navbar_left" onsubmit="return false;">
          <input v-model="keyword" type="text" id="bookTitleField" class="input is-success" placeholder="著書名" />
        </form>
        <span class="icon is-small is-left small_margin">
          <i class="fas fa-book" />
        </span>
        <a href="/" id="close-form" class="is-inline-block has-text-centered navbar_right header-line-hight">
          <i class="fas fa-times" />
        </a>
      </div>
    </nav>
    <div class="hero-body">
      <p class="has-text-weight-bold">
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
