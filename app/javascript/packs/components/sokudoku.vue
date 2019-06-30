<template>
<div>
  <h3 class="title has-text-centered">そくどく！٩( 'ω' )و</h3>
  <button @click="start" class="button" :class="{'is-link': reading}">Start</button>
  <button @click="stop" class="button" :class="{'is-link': !reading}">Stop</button>
  <button @click="reset" class="button">Reset</button>
  <p class="subtitle">
    Speed：{{speed}}ms/word<input v-model="speed" class="slider is-fullwidth is-info" step="10" min="100" max="900" type="range">
  </p>
  <div class="current_slide">{{current_word}}</div>
</div>
</template>
<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      words: [],
      current_num: 0,
      current_word: 'こころ',
      reading: false,
      timerObj: null,
      speed: 180
    }
  },
  mounted: function () {
    this.fetchTasks();
  },
  methods: {
    fetchTasks: function () {
      axios.get('/api/books/10').then((response) => {
        this.words = response.data.words
      }, (error) => {
        console.log(error);
      });
    },
    count: function() {
      if(this.current_num >= this.words.length - 1){
        return this.stop()
      }
      this.current_num++
      this.current_word = this.words[this.current_num].text
    },
    start: function() {
      this.current_word = this.words[this.current_num].text
      this.reading = true
      this.count()
      this.timerObj = setTimeout(this.start, this.speed);
      // this.timerObj = setInterval(function() {self.count()}, this.speed)
    },
    stop: function(){
      clearTimeout(this.timerObj)
      this.reading = false
    },
    reset: function(){
      this.current_word = 'こころ'
      this.current_num = 0
    }
  }
}
</script>

<style>
.title{
  margin-top: 20px;
}
li{
  background: #333;
  color: #fff;
  width: 100%;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.current_slide{
  font-size: 55px;
  background: #333;
  color: #fff;
  width: 100%;
  height: 80%;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
