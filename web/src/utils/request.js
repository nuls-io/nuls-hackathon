import Vue from 'vue'
import axios from 'axios';
Vue.prototype.$axios = axios;

// 创建axios实例
const service = axios.create({
    baseURL: process.env.VUE_APP_BASE_API, // api的base_url
    timeout: 15000 // 请求超时时间
})
// request拦截器
service.interceptors.request.use(config => {
    return config
  }, error => {
    console.log("request拦截器报错："+error)
    Promise.reject(error)
  })

// respone拦截器
service.interceptors.response.use(response => {
  const res = response.data
  if (res.code != 1) {
    if (res.code == 2){
      store.dispatch('LogOut')
    }
    return Promise.reject(res)
  } else {
    return res
  }
},
error => {
  return Promise.reject(error)
}
)
  
  export default service
