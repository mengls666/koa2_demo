<template>
  <div class="market">
    <h1>浏览商店</h1>
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
      this.$http({
        method: 'get',
        url: this.$util.baseUrl + 'items/allItems',
      })
        .then(res => {
          this.tableData = res.data.data
          //console.log(res)
        })
        .then(err => {
          //console.log(err)
        })
    },
  },
  created () {
    this.getMarket()
  }
}
</script>
