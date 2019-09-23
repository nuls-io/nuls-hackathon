<template>
  <div class="wrapper">
    <div class="loading-bar" :class="nowStatus">
      <span class="press"></span>
    </div>
    <transition :name="transitionName">
      <router-view></router-view>
    </transition>
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import './assets/css/common.scss'
import Rem from '@/assets/js/rem'
new Rem();
export default {
  name: 'app',
  data () {
    return {
      transitionName : 'slide-go',
    }
  },
  computed: {
    ...mapGetters([
      'nowStatus'
    ]),
  },
  watch: {
    $route(to, from) {
      if(to.meta.index > from.meta.index){
        this.transitionName = 'slide-go';
      }else{
        this.transitionName = 'slide-back';
      }
      this.nowUrl = to.fullPath
    }
  },
  methods: {
  },
}
</script>

<style lang="scss">
.wrapper {
  width: 100%; height: 100%;
  max-width: 7.5rem; margin: 0 auto;
}
</style>
