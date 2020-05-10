<template>
  <div class="market">
    <h1>商店</h1>
    <h2>您的余额为:{{amount}} <el-button type='mini' @click="getAmount()">刷新</el-button></h2>
    <div class="table">
      <el-table
        :data="tableData"
        height="250"
        border
        style="width: 70%"
        center="true"
      >
        <el-table-column prop="id" label="商品id"></el-table-column>
        <el-table-column prop="name" label="商品名"></el-table-column>
        <el-table-column prop="nickname" label="拥有者"></el-table-column>
        <el-table-column prop="amount" label="数量"></el-table-column>
        <el-table-column prop="price" label="单价"></el-table-column>
        <el-table-column align="right" label="操作">
          <template slot-scope="scope">
          <el-popover placement="right" width="400">
            <p>请输入你要购买的数量:</p>
            <el-input v-model="input"></el-input>
            <el-button @click="handleBuy(scope.$index, scope.row)">确认</el-button>
            <el-button slot="reference">购买</el-button>
          </el-popover>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <h2><el-button type='primary' @click="goHome()">返回首页</el-button></h2>
  </div>
</template>
<script>
export default {
  name: 'test',
  data () {
    return {
      tableData: '',
      visible2: false,
      input: '',
      amount: ''
    }
  },
  methods: {
    goHome () {
      this.$router.push({ path: '/home' })
    },
    getMarket () {
      var userid = JSON.parse(sessionStorage.getItem('userInfo')).id
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/findMarket',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          user_id: userid
        }
      })
        .then(res => {
          this.tableData = res.data.data
          //console.log(res)
        })
        .then(err => {
          //console.log(err)
        })
    },
    handleBuy (index, row) {
      var userid = JSON.parse(sessionStorage.getItem('userInfo')).id
      if (this.input === '0' || this.input === '') {
        this.$toast('数量不能为空')
        return
      }
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/buy',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          buyer: userid,
          name: row.name,
          amount: this.input.trim(),
          market_id: row.id
        }
      }).then((res) => {
        if (res.data.code === '800000') {
          this.$toast('购买成功！')
          // eslint-disable-next-line no-implied-eval
          setTimeout('location.reload()', 1000)
        } else {
          this.$toast(res.data.mess)
        }
      }).then((err) => {
        //console.log(err)
      })
    },
    getAmount () {
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'users/amount',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          id: JSON.parse(sessionStorage.getItem('userInfo')).id
        }
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
    this.getMarket()
    this.getAmount()
  }
}
</script>
