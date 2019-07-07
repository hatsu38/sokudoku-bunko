<template>
  <div>
    <h3 class="subtitle has-text-centered">そくどく！٩( 'ω' )و</h3>
    <div class="buttons">
      <button @click="start" class="button" :class="{'is-link': reading}"><i class="fas fa-play"></i>Start</button>
      <button @click="stop" class="button" :class="{'is-link': !reading}"><i class="fas fa-stop"></i>Stop</button>
      <button @click="reset" class="button"><i class="fas fa-backward"></i>Reset</button>
    </div>
    <p class="subtitle is-marginless">
      Speed：{{speed}}ms/word
    </p>
    <input v-model="speed" class="slider has-background-info is-fullwidth is-info" step="10" min="100" max="900" type="range">
    <div class="current_slide">{{current_word}}</div>
  </div>
</template>
<script>
import axios from 'axios';
import Router from '../router'
export default {
  router: Router,
  data: function () {
    return {
      words: [],
      current_num: 0,
      current_word: '',
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
      axios.get(`/api/books/${this.$route.params.id}`).then((response) => {
        this.words = response.data.words
        this.current_word = this.words[0].text
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
      this.current_word = this.words[0].text
      this.current_num = 0
    }
  }
}
</script>

<style>
#words{
  text-align: center;
}
.buttons{
  justify-content: center;
}
.button > i, .button > svg{
  margin-right: 5px;
}
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
  font-size: 35px;
  background: #333;
  color: #fff;
  width: 100%;
  height: 80%;
  display: flex;
  justify-content: center;
  align-items: center;
}
input[type=range] {
  -webkit-appearance:none;
  height: 13px;
  width: 100%;
  cursor: pointer;
}
input[type=range]::-webkit-slider-thumb{
  -webkit-appearance:none;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
  border: 1px solid #000000;
  height: 20px;
  width: 16px;
  border-radius: 3px;
  background: #ffffff;
  cursor: pointer;
}
</style>
