// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import VueResource from 'vue-resource' 
import VueBus from 'vue-bus'
import Vuetify from 'vuetify'
import 'babel-polyfill'  //IE11 & Safari 9 support
// 自定义
import store from './store'
import base from './base'
import router from './config/routers' 
import 'vuetify/dist/vuetify.min.css'


Vue.config.productionTip = false 
Vue.use(VueResource)
Vue.use(Vuetify)
Vue.use(VueBus)  

Vue.use(base);
 
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>',
  beforeCreate() {
    // APP 构建初始化 sotre 
		this.$store.commit('initialiseStore');
	}
})
