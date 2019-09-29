import request from '../utils/request'

//首页列表
export function Works(data) {
  return request({
    url: '/Index/Works',
    method: 'post',
    data
  })
}
//详情
export function WorksDetails(data) {
  return request({
    url: '/Index/WorksDetails',
    method: 'post',
    data
  })
}
//热门视频
export function HotBroadcast(data) {
  return request({
    url: '/Index/HotBroadcast',
    method: 'post',
    data
  })
}
//喜欢视频
export function WorksLike(data) {
  return request({
    url: '/Index/WorksLike',
    method: 'post',
    data
  })
}
//证书
export function Credentials(data) {
  return request({
    url: '/Index/Credentials',
    method: 'post',
    data
  })
}
