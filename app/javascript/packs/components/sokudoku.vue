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
    <input v-model="speed" class="slider has-background-info is-fullwidth is-info" step="5" min="10" max="500" type="range">
    <div class="current_slide">{{currentWord}}</div>
    <div class="mask-relative">
      <div class="mask has-background-white"></div>
    </div>
    <div id="sentence-text" class="vertical-sentence">
      <h2 class="title is-5 has-text-weight-bold">{{title}}</h2>
      <p>
        <span v-for="(word, idx) in words" :class="{'currentText': idx == currentNum }">{{word.text}}</span>
      </p>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import Router from '../router'
import jQuery from 'jquery'
global.jquery = jQuery
global.$ = jQuery
window.$ = window.jQuery = require('jquery')

export default {
  router: Router,
  data: function () {
    return {
      words: [],
      title: '',
      currentNum: 0,
      currentWord: '',
      reading: false,
      timerObj: null,
      speed: 180,
      currentTextPosition: 0,
      initialCurrentTextPosition: 0
    }
  },
  created: function () {
    this.fetchWords();
  },
  updated: function(){
    this.currentWord = this.words[0].text
    this.initialCurrentTextPosition = document.getElementById('sentence-text').scrollLeft
  },
  watch: {
    currentNum: function(){
      if(this.currentNum % 10 == 0){
        this.getCurrentTextPosition()
      }
    },
    currentTextPosition: function(){
      if(this.currentTextPosition < 200 ){
        this.slideScroll()
      }
    }
  },
  methods: {
    fetchWords: function () {
      axios.get(`/api/books/${this.$route.params.id}`).then((response) => {
        this.title = response.data.title
        this.words = response.data.words
      }, (error) => {
        console.log(error);
      });
    },
    count: function() {
      if(this.currentNum >= this.words.length - 1){
        return this.stop()
      }
      this.currentNum++
      this.currentWord = this.words[this.currentNum].text
    },
    start: function() {
      this.currentWord = this.words[this.currentNum].text
      this.reading = true
      this.count()
      this.timerObj = setTimeout(this.start, this.speed);
    },
    stop: function(){
      clearTimeout(this.timerObj)
      this.reading = false
    },
    reset: function(){
      this.currentWord = this.words[0].text
      this.currentNum = 0;
      $('#sentence-text').animate({scrollLeft: this.initialCurrentTextPosition+500}, 1000, 'swing');
    },
    slideScroll: function(){
      var targetX = document.getElementById('sentence-text').scrollLeft -= 50;
      $('#sentence-text').animate({scrollLeft: targetX}, 500, 'swing');
    },
    getCurrentTextPosition: function(){
      this.currentTextPosition = document.getElementsByClassName('currentText')[0].getBoundingClientRect().left;
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

.currentText{
  background: #209cee;
  color: #fff;
  padding: 2px;
  border-radius: 5px;
}
.current_slide{
  font-size: 22px;
  background: #333;
  color: #fff;
  width: 100%;
  padding: 5px 0;
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

.vertical-sentence{
  writing-mode: vertical-rl;
  -ms-writing-mode: tb-rl;
  max-width: 100%;
  height: 450px;
  overflow: hidden;
  padding: 25px 10px;
  overflow-x: auto;
  line-height: 2.2rem;
  text-align: justify;
}
.vertical-sentence h2{
  margin-top: 0;
  margin-left: 15px;
}
.mask-relative{
  position: relative;
}
.mask{
  position: absolute;
  left: 0;
  opacity: .8;
  width: 28%;
  height: 450px;
  z-index: 5;
}

</style>
