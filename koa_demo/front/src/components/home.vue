<template>
    <div class="home">
        <h1>{{ user }},欢迎来到购物系统！</h1>
        <h2>您的余额为:{{amount}} <el-button type='mini' @click="getAmount()">刷新</el-button></h2>
        <el-button type='primary' @click="goMarket">进入商店</el-button>
        <el-button type='primary' @click="goHouse">进入仓库</el-button>
        <el-button type='primary' @click="myMarket">我的商店</el-button>
    </div>
</template>
<script>
export default {
  data () {
    return {
      user: JSON.parse(sessionStorage.getItem('userInfo')).nickname,
      amount: ''
    }
  },
  methods: {
    goMarket () {
      this.$router.push({path: '/market'})
    },
    goHouse () {
      this.$router.push({path: '/house'})
    },
    myMarket () {
      this.$router.push({path: '/mymarket'})
    },
    getAmount () {
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'users/amount',
        params: {
          id: JSON.parse(sessionStorage.getItem('userInfo')).id
        },
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
      }).then((res) => {
        if (res.data.code === '800000') {
          this.amount = res.data.mess
          //console.log(res.data)
        } else {
          this.$toast(res.data.mess)
        }
      }).then((err) => {
        //console.log(err)
      })
    }
  },
  created () {
    this.getAmount()
  }
}
</script>
