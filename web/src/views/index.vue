<template>
  <div class="app-init scroll">
    <div class="title">
      HI，短视保<br />
      做一个有来历的视频
    </div>
    <div class="main">
      <div class="content">
        <ul>
          <li v-for="(item,index) in tableData" :key="index">
            <router-link :to="{path:'/detail',query: { works_id: item.works_id}}">
            <div class="img"><img :src="staticUrl+item.works_videos_image" :alt="item.title"></div>
            <div class="info">
              <div class="tit">{{item.works_name}}</div>
              <div class="anchor">
                <div class="name">{{item.works_author}}</div>
                <div class="visitor">{{item.works_click}}</div>
              </div>
            </div>
            </router-link>
          </li>
        </ul>
        <div class="loadmore">到底啦~去APP，观看更多视频~</div>
      </div>
    </div>
    
  </div>
</template>

<script>
import { Works } from '@/api/chain'
export default {
  name: 'index',
  components: {
  },
  data () {
    return {
      staticUrl:'http://52.82.14.217:7015/', //静态服务器域名
      tableData:[],
      tableDataLength:0,
      listQuery: {
        start: 0,
        length: 100,
        showLoadMore:false
      },
    }
  },
  created() {
    this.fetchData()
  },
  methods:{
    fetchData() { //拉出数据
      let para = {
        start:this.listQuery.start,//起始位置
        length:this.listQuery.length,//长度
      }
      Works(para).then(response => {
        this.tableData = response.data.data
        this.tableDataLength = response.data.itotalDisplayRecords
      }).catch(error => {
        console.log(error.message)
      })
    },
  }
}
</script>

<style lang="scss" scoped>
.title {
  width: 100%;text-align: center;font-size: .66rem;line-height: 0.9rem;font-weight: 700; padding: 0.4rem;
}

.main {
  background-color: #fff;border-radius: 0.35rem;min-height: 5rem;
  .content {
    background-color: #f4f4f4;
    ul {
      display: flex; justify-content: space-between;flex-wrap:wrap;
      li {
        width: 3.72rem;overflow: hidden; background-color: #fff; margin-bottom: 0.06rem;
        a {
          display: block;
        }
        .img {
          width: 3.72rem; height: 3.72rem;
          img {width: 100%; height: 100%;}
        }
        .info {
          padding: .2rem;
          .tit {
            color: #333; font-size: 0.28rem; margin-bottom: 0.07rem;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;
          }
          .anchor {
            width: 100%; overflow: hidden; font-size: 0.24rem; color: #999;
            .name {
              float: left;
              overflow: hidden;
              text-overflow:ellipsis;
              white-space: nowrap;
              width: 2.5rem;
            }
            .visitor {
              float: right;
            }
            .visitor:before {
              content: " ";
              display: block;
              float: left;
              width: .3rem;
              height: .3rem;
              margin-right: .06667rem;
              background-size: 100%;
              background-image: url('../../public/images/hot.png');
            }
          }
        }
      }
    }
    .loadmore {
      padding: .4rem 0; color: #999; text-align: center;
    }
  }
}


</style>
