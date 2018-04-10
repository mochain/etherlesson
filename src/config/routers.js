import Vue from 'vue'
import Router from 'vue-router'
import Contract from '@/pages/contract'
// import Setting from '@/pages/setting'
import Home from '@/pages/home'


import App from '../App'

Vue.use(Router)

export default new Router({
  routes: [
    {path:"/",component:Home},
    { path: '/contract/list', component: Contract },
    { path: '/setting', component: ()=> import("@/pages/setting") },
  ]
})
