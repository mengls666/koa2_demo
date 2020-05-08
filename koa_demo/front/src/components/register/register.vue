<template>
    <div class="star-login">
        <h1>注册</h1>
        <div class="login-wraper">
            <div class="avatar" :style="`background-image:url(${avatar})`"></div>
            <div class="input-group">
                <label for="nickname">昵称</label><input type="text" id="nickname" v-model="nickname">
            </div>
            <div class="input-group input-group-panel">
                <label for="username">账号</label><input type="text" id="username" v-model="username">
            </div>
            <div class="input-group input-group-panel">
                <label for="userpwd">密码</label><input type="password" id="userpwd" v-model="userpwd">
            </div>
            <el-button type="primary" class="sign" @click="register">注册</el-button>
            <span class="badge-img">+</span>
        </div>
        <br>
        <el-button type="primary" class="register" @click="login">已经有账号了？点击登录</el-button>
    </div>
</template>
<script>
import crypto from 'crypto'
export default {
  methods: {
    register () {
      var md5 = crypto.createHash('md5')
      md5.update(this.userpwd.trim())
      var passwd = md5.digest('Hex')
      if (this.nickname.trim() === '' || this.nickname.trim() == null) {
        this.$toast('请输入账号')
        return
      }
      if (this.username.trim() === '' || this.username.trim() == null) {
        this.$toast('请输入账号')
        return
      }
      if (this.userpwd.trim() === '' || this.userpwd.trim() == null) {
        this.$toast('请输入密码')
        return
      }
      this.$http({
        method: 'post',
        url: this.$util.baseUrl + 'users/userRegister',
        data: {
          nickname: this.nickname.trim(),
          username: this.username.trim(),
          userpwd: passwd
        }
      }).then((res) => {
        console.log(res)
        if (res.data.code === '800000') {
          this.$router.push({path: '/login'})
        } else {
          this.$toast(res.data.mess)
        }
      }).then((err) => {
        console.log(err)
      })
    },
    login () {
      this.$router.push({path: '/login'})
    }
  }
}
</script>
