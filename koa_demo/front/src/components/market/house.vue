<template>
  <div class="market">
    <h1>我的仓库</h1>
    <h2>
      您的余额为:{{ amount }}
      <el-button type="mini" @click="getAmount()">刷新</el-button>
    </h2>
    <div class="table">
      <el-table
        :data="tableData"
        height="250"
        border
        style="width: 70%"
        center="true"
      >
        <el-table-column prop="name" label="商品名"></el-table-column>
        <el-table-column prop="amount" label="数量"></el-table-column>
        <el-table-column align="right" label="操作">
          <template slot-scope="scope">
            <el-popover placement="right" width="400">
              <p>请输入你要取回的数量:</p>
              <el-input v-model="num"></el-input>
              <el-button @click="handlePop(scope.$index, scope.row)"
                >确认</el-button
              >
              <el-button slot="reference">取回</el-button>
            </el-popover>
            <el-popover placement="right" width="400">
              <p>请输入你要出售的数量:</p>
              <el-input v-model="num"></el-input>
              <p>请输入你要出售的价格:</p>
              <el-input v-model="price"></el-input>
              <el-button @click="handleSell(scope.$index, scope.row)"
                >确认</el-button
              >
              <el-button slot="reference">出售</el-button>
            </el-popover>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div>
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item label="数量">
          <el-input v-model="add.amount" placeholder="请输入数量"></el-input>
        </el-form-item>
        <el-form-item label="物品名">
          <el-input v-model="add.name" placeholder="请输入物品名"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleAdd()">添加物品</el-button>
        </el-form-item>
      </el-form>
    </div>
    <h2><el-button type="primary" @click="goHome()">返回首页</el-button></h2>
  </div>
</template>
<script>
export default {
  name: 'test',
  data () {
    return {
      add: {
        name: '',
        amount: ''
      },
      tableData: '',
      visible2: false,
      num: '',
      price: '',
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
        url: this.$util.baseUrl + 'items/myHouse',
        headers: {
            'Authorization': 'Bearer ' +localStorage.getItem('token')
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
    handleSell (index, row) {
      var userid = JSON.parse(sessionStorage.getItem('userInfo')).id
      if (this.num === '0' || this.num === '') {
        this.$toast('数量不能为空')
        return
      }
      if (this.price === '') {
        this.$toast('价格不能为空')
        return
      }
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/sell',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          id: userid,
          name: row.name,
          amount: this.num.trim(),
          price: this.price.trim()
        }
      })
        .then(res => {
          if (res.data.code === '800000') {
            this.$toast('出售成功！')
            // eslint-disable-next-line no-implied-eval
            setTimeout('location.reload()', 1000)
          } else {
            this.$toast(res.data.mess)
          }
        })
        .then(err => {
          //console.log(err)
        })
    },
    handlePop (index, row) {
      var userid = JSON.parse(sessionStorage.getItem('userInfo')).id
      if (this.num === '0' || this.num === '') {
        this.$toast('数量不能为空')
        return
      }

      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/pop',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          id: userid,
          amount: this.num.trim(),
          name: row.name
        }
      })
        .then(res => {
          if (res.data.code === '800000') {
            this.$toast('取回成功！')
            // eslint-disable-next-line no-implied-eval
            setTimeout('location.reload()', 1000)
          } else {
            this.$toast(res.data.mess)
          }
        })
        .then(err => {
          //console.log(err)
        })
    },
    handleAdd (index, row) {
      var userid = JSON.parse(sessionStorage.getItem('userInfo')).id
      if (this.add.amount === '0' || this.add.amount === '') {
        this.$toast('数量不能为空')
        return
      }
      if (this.add.name === '') {
        this.$toast('物品名不能为空')
        return
      }
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/addstock',
        headers: {
            'Authorization': 'Bearer ' + localStorage.getItem('token')
        },
        params: {
          id: userid,
          amount: this.add.amount.trim(),
          name: this.add.name
        }
      })
        .then(res => {
          if (res.data.code === '800000') {
            this.$toast('添加成功！')
            // eslint-disable-next-line no-implied-eval
            setTimeout('location.reload()', 1000)
          } else {
            this.$toast(res.data.mess)
          }
        })
        .then(err => {
          //console.log(err)
        })
    },
    getAmount () {
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'users/amount',
        headers: {
            'Authorization': 'Bearer ' +  localStorage.getItem('token')
        },
        params: {
          id: JSON.parse(sessionStorage.getItem('userInfo')).id
        }
      })
        .then(res => {
          if (res.data.code === '800000') {
            this.amount = res.data.mess
            //console.log(res.data)
          } else {
            this.$toast(res.data.mess)
          }
        })
        .then(err => {
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
