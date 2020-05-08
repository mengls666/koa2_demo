<template>
    <div class="test-index">
        <el-button type='primary' @click="goHome">进入主页</el-button>
    </div>
</template>
<script>
export default {
  name: 'test',
  methods: {
    goHome () {
      this.$router.push({path: '/home'})
    }
  }
}
</script>
