import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  //mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      redirect: '/index'
    },
    {
      path: '/index',
      name: 'index',
      meta: { 
        title: '发现',
        auth: false,
        index:1
      },
      component: () => import(/* webpackChunkName: "index" */ '@/views/index')
    },
    {
      path: '/detail',
      name: 'detail',
      meta: { 
        title: '播放',
        auth: false,
        index:2
      },
      component: () => import(/* webpackChunkName: "detail" */ '@/views/detail')
    },
    {
      path: '/certificate',
      name: 'certificate',
      meta: { 
        title: '证书',
        auth: false,
        index:3
      },
      component: () => import(/* webpackChunkName: "certificate" */ '@/views/certificate')
    },
  ]
})
