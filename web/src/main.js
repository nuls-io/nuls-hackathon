import Vue from 'vue'
import App from './App.vue'
import router from './router/index'
import store from './store/index'

router.beforeEach((to, from, next)=>{
  store.commit('nowStatus', 'loading')
  next();
})

router.afterEach((to, from, next)=>{
  store.commit('nowStatus', 'end')
  setTimeout(()=>{
    store.commit('nowStatus', 'hide')
  }, 900)
  setTimeout(()=>{
    store.commit('nowStatus', 'normal')
  }, 1000)
})

Vue.config.productionTip = false

// hack for active mobile
document.addEventListener("touchstart", function(){}, true)

import VideoPlayer from 'vue-video-player'
require('video.js/dist/video-js.css')
require('vue-video-player/src/custom-theme.css')
Vue.use(VideoPlayer)

Vue.filter('dateformat', function(timestamp) {
  let date = new Date(timestamp * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
  let Y = date.getFullYear() + '-';
  let M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
  let D = date.getDate() + ' ';
  let h = date.getHours() + ':';
  let m = (date.getMinutes() < 10 ? '0'  + date.getMinutes() : date.getMinutes()) + ':';
  let s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds();
  return Y+M+D+h+m+s;
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
