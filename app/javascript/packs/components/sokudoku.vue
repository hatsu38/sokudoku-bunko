<template>
  <div>
    <h3 class="is-size-5 has-text-centered has-text-weight-bold push-top push-bottom">そくどく！٩( 'ω' )و</h3>
    <p v-show="moveToCurrentPosition" @click="movePosition" class="has-text-centered has-text-weight-bold has-text-danger push-bottom">現在地へスクロールする</p>
    <div class="buttons is-marginless">
      <button @click="start" class="button" :class="{'is-link': reading}"><i class="fas fa-play"></i>Start</button>
      <button @click="stop" class="button" :class="{'is-link': !reading}"><i class="fas fa-stop"></i>Stop</button>
      <button @click="reset" class="button"><i class="fas fa-backward"></i>Reset</button>
    </div>
    <p @click="open" id="zoom_btn" class="has-text-link has-text-centered push-bottom">そくどくモードで見る</p>
    <p class="subtitle is-marginless has-text-centered">
      Speed：{{speed}}ms/word
    </p>
    <input v-model="speed" class="slider has-background-info is-fullwidth is-info" step="5" min="10" max="500" type="range">
    <div class="current_slide">{{currentWord}}</div>
    <div id="sokudoku-modal" class="modal">
      <div class="modal-background"></div>
      <div class="modal-content">
        <div class="buttons">
            <button @click="start" class="button is-white" :class="{'is-outlined': !reading}"><i class="fas fa-play"></i>Start</button>
            <button @click="stop" class="button is-white" :class="{'is-outlined': reading}"><i class="fas fa-stop"></i>Stop</button>
            <button @click="reset" class="button is-outlined is-white reset-button"><i class="fas fa-backward"></i>Reset</button>
          </div>
          <p class="subtitle is-marginless has-text-centered has-text-white">
            Speed：{{speed}}ms/word
          </p>
          <input v-model="speed" class="slider has-background-white" step="5" min="10" max="500" type="range">
          <div class="current_slide">{{currentWord}}</div>
      </div>
      <button @click="close" class="modal-close is-large" aria-label="close"></button>
    </div>
    <div class="mask-relative">
      <div class="mask has-background-white"></div>
    </div>
    <div id="sentence-text" class="vertical-sentence">
      <h2 class="title is-5 has-text-weight-bold">{{title}}</h2>
      <p id="sentence">
        <span v-for='(word, idx) in words' :key="idx" :class="{'currentText': idx == currentNum }">{{word.text}}</span>
      </p>
      <p @click="moreSentence" id="sentence-more-read">もっと読み込む</p>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import Router from '../router'

export default {
  router: Router,
  data() {
    return {
      words: [],
      title: '',
      page: 1,
      currentNum: 0,
      currentWord: '',
      reading: false,
      timerObj: null,
      speed: 180,
      moveToCurrentPosition: false
    }
  },
  created() {
    this.fetchWords()
  },
  watch: {
    currentNum() {
      if(this.currentNum % 10 == 0){
        this.slideScroll()
      }
      if(this.currentNum >= this.words.length - 50){
        this.moreSentence()
      }
    }
  },
  methods: {
    fetchWords() {
      axios.get(`/api/books/${this.$route.params.title}?page=${this.page}`)
      .then((response) => {
        this.title = response.data.title
        this.words = response.data.words
        this.currentWord = this.title
        this.page++
        // イケテないが、this.wordsを取得した後にRestart関数が動くのが望ましいためここに記述
        this.restart()
      })
      .catch((error) => {
        console.log(error)
      })
    },
    moreSentence() {
      axios.get(`/api/books/${this.$route.params.title}?page=${this.page}`)
      .then((response) => {
        this.words.push(...response.data.words)
        this.page++
      })
      .catch((error) => {
        console.log(error)
      })
    },
    count() {
      if(this.currentNum >= this.words.length - 1){
        return this.stop()
      }
      this.currentNum++
      this.currentWord = this.words[this.currentNum].text
    },
    start() {
      this.currentWord = this.words[this.currentNum].text
      this.reading = true
      this.count()
      this.timerObj = setTimeout(this.start, this.speed)
    },
    stop() {
      clearTimeout(this.timerObj)
      this.reading = false
      this.setStorage()
    },
    reset() {
      const result = window.confirm("最初に戻りますか？")
      if(!result){ return false }
      this.currentWord = this.words[0].text
      this.currentNum = 0
      this.setStorage()
      $('#sentence-text').animate({scrollLeft: document.getElementById('sentence').clientWidth}, 1000, 'swing')
    },
    slideScroll() {
      var targetX = document.getElementById('sentence-text').scrollLeft - (280 - document.getElementsByClassName('currentText')[0].getBoundingClientRect().left)
      if(targetX < 0){ targetX = targetX * -1 }
      $('#sentence-text').animate({scrollLeft: targetX}, 500, 'swing')
    },
    open(){
      this.stop()
      $("#sokudoku-modal").addClass('is-active')
    },
    close(){
      this.stop()
      $("#sokudoku-modal").removeClass('is-active')
    },
    setStorage() {
      // 30単語目まではほぼ最初なのでStorageに保存しない
      if(this.currentNum <= 30){
        localStorage.removeItem(this.title)
      } else {
        // 文章を取得したらPageに+1がされるので、現在のページは-1をする
        const datalist = {
          page: this.page - 1,
          restartPosition: this.currentNum
        }
        localStorage.setItem(this.title, JSON.stringify(datalist))
      }
    },
    restart() {
      const dataList = JSON.parse(localStorage.getItem(this.title))
      if(!this.restartConfirm(dataList)){
        localStorage.removeItem(this.title)
        return false
      }
      if(dataList.restartPosition % 10 == 0){ dataList.restartPosition -= 1 }
      this.currentNum = dataList.restartPosition
      if(dataList.page > 1){
        this.page = dataList.page
        for(var i = 2; i <= this.page; i++) {
          this.moreSentence()
        }
      }
      this.moveToCurrentPosition = true
    },
    restartConfirm(dataList){
      if(dataList){
        return window.confirm("途中から再開しますか？")
      }else{
        return false
      }
    },
    movePosition(){
      this.currentWord = this.words[this.currentNum].text
      this.slideScroll()
      this.moveToCurrentPosition = false
    }
  }
}
</script>

<style scoped lang="scss">
.buttons{
  justify-content: center;
  > .button{
    > i, svg{
      margin-right: 5px;
    }
  }
}
.title{
  margin-top: 20px;
}
.currentText{
  background: #209cee;
  color: #fefefe;
  padding: 2px;
  border-radius: 5px;
}
.current_slide{
  font-size: 22px;
  background: #333;
  color: #fefefe;
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
  border-radius: 5px;
  cursor: pointer;
}
input[type=range]::-webkit-slider-thumb{
  -webkit-appearance:none;
  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
  border: 1px solid #000000;
  height: 20px;
  width: 16px;
  border-radius: 3px;
  background: #fefefe;
  cursor: pointer;
}
.vertical-sentence{
  writing-mode: vertical-rl;
  -ms-writing-mode: tb-rl;
  max-width: 100%;
  height: 500px;
  overflow: hidden;
  padding: 25px 10px;
  overflow-x: auto;
  line-height: 2.2rem;
  text-align: justify;
  > h2{
  margin-top: 0;
  margin-left: 15px;
}
}
.mask-relative{
  position: relative;
  > .mask{
    position: absolute;
    left: 0;
    opacity: .8;
    width: 28%;
    height: 500px;
    z-index: 5;
  }
}
#sentence-more-read{
  z-index: 9;
  position: relative;
  color: #777777;
}
.modal-background{
  background-color: #333;
}
.modal-content{
  margin-bottom: 70px;
  input[type=range]{
    width: 80%;
    display: block;
    margin: 10px auto 0;
  }
  .current_slide{
    font-size: 30px;
  }
  .reset-button:hover{
    background-color: #333;
    border-color: white;
    color: white;
  }
}
</style>
