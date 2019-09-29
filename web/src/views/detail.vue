<template>
  <div class="app-init scroll">
    <header>
      <a class="back" href="javascript:;" @click="goBack()">返回</a>
      <h2>播放</h2>
    </header>
    <div class="main">
      <div class="content">
        <div class="video">

          <video-player  class="video-player vjs-custom-skin"
            ref="videoPlayer" 
            :playsinline="true" 
            :options="playerOptions"
          ></video-player>

        </div>
        <div class="information">
          <div class="title">
            <h1>{{detail.works_name}}</h1>
            <div class="time">{{detail.works_time | dateformat}}</div>
          </div>        
          <div class="action">
            <a href="javascript:;"><i></i>热度({{detail.works_click}})</a>
            <a href="javascript:;" @click="likeVideo()"><i></i>喜欢({{detail.works_like}})</a>
            <router-link :to="{path:'/certificate',query: { works_id: this.works_id}}" v-if="detail.works_status == 1"><i></i>存证证书</router-link>
            <a href="javascript:;" v-else-if="detail.works_status == 3"><i></i>存证失败</a>
            <a href="javascript:;" v-else><i></i>存证中</a>
          </div>
        </div>
        <div class="movieHot">
          <h2>热播榜</h2>
          <ul>
            <li v-for="(item,index) in hotVideo" :key="index">
              <router-link :to="{path:'/detail',query: { works_id: item.works_id}}">
              <div class="img"><img :src="staticUrl+item.works_videos_image" alt=""></div>
              <h3>{{item.works_author}}</h3>
              <div class="con">{{item.works_name}}</div>
              </router-link>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <!-- 喜欢成功弹窗 -->
    <div class="popUp" v-if="messageShow">
      <div class="popMain">
        <div class="popContent">
          感谢老板送的爱心，更有动力了
        </div>
        <div class="btn">
          <a href="javascript:;" @click="messageShow = false">确定</a>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script>
require('vue-video-player/src/custom-theme.css')
import VideoPlayer from 'vue-video-player'

import { WorksDetails,HotBroadcast,WorksLike } from '@/api/chain'
export default {
  name: 'detail',
  components: {
  },
  data () {
    return {
      staticUrl:'http://52.82.14.217:7015/', //静态服务器域名
      works_id:this.$route.query.works_id,
      detail:{},
      playerOptions : {
        //playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
        autoplay: false, //如果true,浏览器准备好时开始回放。
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 导致视频一结束就重新开始。
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        language: 'zh-CN',
        aspectRatio: '4:4', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [{
          type: "video/mp4",//这里的种类支持很多种：基本视频格式、直播、流媒体等，具体可以参看git网址项目
          src: "" //url地址
        }],
        poster: "", //你的封面地址
        width: document.documentElement.clientWidth, //播放器宽度
        notSupportedMessage: '此视频暂无法播放，请稍后再试', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        controlBar: {
          timeDivider: true,
          durationDisplay: true,
          remainingTimeDisplay: false,
          fullscreenToggle: true  //全屏按钮
        }
      },
      hotVideo:[],//热门视频
      messageShow:false,
    }
  },
  created() {
    this.fetchData()
    this.fetchHotData()
  },
  watch:{
    $route(){ // 只要路径变化 重新获取数据
      this.works_id = this.$route.query.works_id
      this.fetchData()
      this.fetchHotData()
    }
  },
  methods:{
    goBack(){
      this.$router.go(-1);
    },  
    fetchData() { //拉出数据
      let para = {
        works_id:this.works_id.toString()
      }
      WorksDetails(para).then(response => {
        this.detail = response.data
        this.playerOptions.poster = this.staticUrl + response.data.works_videos_image
        this.playerOptions.sources[0].src = this.staticUrl + response.data.works_files
      }).catch(error => {
        alert(error.message)
      })
    },
    fetchHotData() { //拉出热门视频数据
      let para = {}
      HotBroadcast(para).then(response => {
        this.hotVideo = response.data.data
      }).catch(error => {
        alert(error.message)
      })
    },
    likeVideo(){
      let para = {
        works_id:this.works_id.toString()
      }
      WorksLike(para).then(response => {
        this.messageShow = true
        this.fetchData()
      }).catch(error => {
        alert(error.message)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
header {
  position: relative;
  .back {
    width: 0.6rem; height: 0.6rem; position: absolute; top: 0.15rem; left: 0.1rem; text-indent: -9999px;
    background: url('../../public/images/back.png') no-repeat center center; background-size: 0.4rem auto;
  }
  h2 {
    font-size: 0.34rem; text-align: center; line-height: 0.9rem; width: 100%;
    border-bottom: solid 1px #f7f7f7;
  }
}

.content {
  .video {
    width: 7.5rem; height: auto;background-color: #ccc;
  }
  .information {
    .title {
      width: 100%; overflow: hidden; line-height: 0.5rem; border-bottom: 1px solid #f7f7f7; padding:0.3rem 0.3rem;
      h1 {
        font-size: 0.34rem; width: 4.4rem; float: left;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;
      }
      .time {
        float: right; width: 2.4rem;
        font-size: 0.24rem; font-weight: normal; color: #999; text-align: right;
      } 
    }
    .action {
      width: 100%; display: flex; justify-content: space-between; padding:0.3rem 0.4rem; border-bottom: 1px solid #f7f7f7;
      a {
        display: block; font-size: 0.26rem; color: #666; text-align: center; width: 33.33%;
        i {
          width: 0.6rem; height: 0.6rem;display: block; margin: 0 auto 0.1rem auto; background-position: center center; background-repeat: no-repeat; background-size: contain;background-image: url('../../public/images/action_hot.png');
        }
      }
      a:nth-child(2) {
        i {background-image: url('../../public/images/action_like.png');}
      }
      a:nth-child(3) {
        i {background-image: url('../../public/images/action_copy.png');}
      }
    }
  }
  .movieHot {
    h2 {
      font-size: 0.3rem; padding: 0.2rem 0.3rem;
    }
    ul {
      padding: 0rem 0.3rem 0.3rem 0.3rem; display: flex; justify-content: space-between;flex-wrap:wrap;
      li {
        margin-bottom: 0.2rem; width: 33.3%;
        a {
          display: block;
        }
        .img {
          background-color: #ccc;width: 2.2rem; height: 2.2rem; margin-bottom: 0.1rem;
          img {
            width: 100%; height: auto;
          }
        }
        h3 {
          font-size: 0.26rem; font-weight: normal; line-height: 0.5rem;
        }
        .con {
          font-size: 0.22rem;color: #999; width: 100%; overflow: hidden;text-overflow:ellipsis;white-space: nowrap;
        }
      }
    }
  }
}

.popUp {
  position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.8); z-index: 9999;
  .popMain {
    position: absolute; left: 50%; top: 50%;
    transform: translate(-50%,-50%);
    background-color: #fff; border-radius: 0.2rem;
    .popContent {
      padding: 0.8rem 0.4rem 0.5rem 0.4rem; text-align: center; min-width: 5rem;font-size: 0.28rem;
    }
    .btn {
      display: flex; justify-content: space-between; padding: 0 0.4rem 0.4rem 0.4rem;
      a {
        width: 100%; height: 0.82rem; line-height: 0.82rem; text-align: center; font-size: 0.3rem;
        font-weight: bold;display: block;background:#7e4985; color: #fff;border-radius: 0.2rem; 
      }
    }
  }
}

</style>
