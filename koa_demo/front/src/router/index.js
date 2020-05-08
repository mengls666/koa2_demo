import Vue from 'vue'
import Router from 'vue-router'
// eslint-disable-next-line no-unused-vars
import home from '@/components/home'
import test from '@/components/test'
import register from '@/components/register/register'
import login from '@/components/login/login'
import market from '@/components/market/market'
import mymarket from '@/components/market/mymarket'
import house from '@/components/market/house'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'test',
      component: test,
      meta: {
        title: 'test' // 动态显示标题使用这个值
      }
    },
    {
      path: '/register',
      name: 'register',
      component: register,
      meta: {
        title: '注册'
      }
    },
    {
      path: '/login',
      name: 'loginpage',
      component: login,
      meta: {
        title: '登录'
      }
    },
    {
      path: '/home',
      name: 'home',
      component: home,
      meta: {
        title: 'homepage'
      }
    },
    {
      path: '/market',
      name: 'market',
      component: market,
      meta: {
        title: '商店'
      }
    },
    {
      path: '/mymarket',
      name: 'mymarket',
      component: mymarket,
      meta: {
        title: '我的商店'
      }
    },
    {
      path: '/house',
      name: 'house',
      component: house,
      meta: {
        title: '我的仓库'
      }
    }
  ]
})
