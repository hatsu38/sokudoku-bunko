import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Sokudoku from './components/sokudoku'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/books/:title', component: Sokudoku },
  ],
})
