<template>
  <nav class="is-fixed-top light-border-bottom is-flex">
    <div class="control has-icons-left has-icons-right is-flex is-fluid container field">
      <form class="small_margin navbar_left">
        <input v-model="keyword" type="text" id="bookTitleField" class="input is-success" placeholder="著書名" />
      </form>
      <span class="icon is-small is-left small_margin">
        <i class="fas fa-book" />
      </span>
      <a href="/" id="close-form" class="is-inline-block has-text-centered navbar_right header-line-hight">
        <i class="fas fa-times" />
      </a>
    </div>
    <p>{{keyword}}</p>
  </nav>
</template>

<script>
export default {
  data() {
    return{
      keyword: this.$parent.keyword
    }
  },
}
</script>
