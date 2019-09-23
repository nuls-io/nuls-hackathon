<template>
  <div class="app-init scroll">
    <header>
      <a class="back" href="javascript:;" @click="goBack()">返回</a>
      <h2>视频存证信息</h2>
    </header>
    <div class="main">
      <div class="content">

        <div class="information">
          <h2>存证信息</h2>
          <div class="box">源文件HASH：<a href="javascript:;">{{detail.files_hash}}</a></div>
          <div class="box">区块链HASH：<a :href="'http://52.82.14.217:1999/transaction/info?hash='+detail.block_hash" target="_blank">{{detail.block_hash}}</a></div>
        </div>
        <div class="certificate">
          <img :src="works_files" alt="">
        </div>
        <div class="btn">
          <a :href="works_files" target="_blank" download="certificate">下载证书</a>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script>
import { Credentials } from '@/api/chain'
export default {
  name: 'certificate',
  components: {
  },
  data () {
    return {
      staticUrl:'http://52.82.14.217:7015/', //静态服务器域名
      works_id:this.$route.query.works_id,
      detail:{},
      works_files:''
    }
  },
  created() {
    this.fetchData()
  },
  methods:{
    goBack(){
      this.$router.go(-1);
    },  
    fetchData() { //拉出数据
      let para = {
        works_id:this.works_id.toString()
      }
      Credentials(para).then(response => {
        this.detail = response.data
        this.works_files = this.staticUrl + response.data.works_files
      }).catch(error => {
        alert(error.message)
      })
    },
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
  .information {
    padding: 0.3rem;
    h2 {
      font-size: 0.34rem; color: #7e4985; margin-bottom: 0.2rem;
    }
    .box {
      word-wrap: break-word;word-break: normal; margin-bottom: 0.2rem;
    }
    .box:last-child {
      margin-bottom: 0;
    }
    a {
      text-decoration: underline;color: #7e4985; 
    }
  }
  .certificate {
    width: 100%;
    img {
      width: 100%; height: auto;
    }
  }
  .btn {
    padding: 0.3rem 0.3rem 0.8rem 0.3rem;
    a {
      width: 100%; display: block; line-height: 0.8rem; height: 0.8rem; text-align: center; color: #fff;border-radius: 0.8rem;background-color: #7e4985;
    }
  }
}

</style>
