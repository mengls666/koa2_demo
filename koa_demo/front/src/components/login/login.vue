<template>
    <div class="star-login">
        <h1>登录</h1>
        <div class="login-wraper">
            <div class="avatar" :style="`background-image:url(${avatar})`"></div>
            <div class="input-group input-group-panel">
                <label for="username">账号</label><input type="text" id="username" v-model="username">
            </div>
            <div class="input-group input-group-panel">
                <label for="userpwd">密码</label><input type="password" id="userpwd" v-model="userpwd">
            </div>
            <el-button type="primary" class="sign" @click="login">登录</el-button>
            <el-button type="primary" class="show" @click="show">查看商店</el-button>
        </div>
        <br><br>
        <el-button type="primary" class="register" @click="register">新用户?点击注册</el-button>
    </div>
</template>
<script>
import crypto from 'crypto'
export default {
  methods: {
    data () {
      return {
        username: '',
        userpwd: ''
      }
    },
    show () {
      this.$router.push({path: '/show'})
    },
    login () {
      var md5 = crypto.createHash('md5')
      md5.update(this.userpwd.trim())
      var passwd = md5.digest('Hex')
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
        url: this.$util.baseUrl + 'users/userLogin',
        data: {
          username: this.username.trim(),
          userpwd: passwd
        }
      }).then((res) => {
        //console.log(res)
        if (res.data.code === '800000') {
          localStorage.setItem('token', res.data.data.token)
          sessionStorage.setItem('userInfo', JSON.stringify(res.data.data))
          this.$toast(res.data.data.nickname + ', 欢迎登陆!')
          this.$router.push({path: '/home'})
        } else {
          this.$toast(res.data.mess)
        }
      }).then((err) => {
        //console.log(err)
      })
    },
    register () {
      this.$router.push({path: '/register'})
    }
  }
}
</script>
