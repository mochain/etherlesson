import Vue from 'vue'
import Vuex from 'vuex'
import setting from './modules/setting' 

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

const store = new Vuex.Store({
  modules: {
    setting,
  },
  strict: debug, 
  mutations: {
    // 从 本地存储中初始化 Store
		initialiseStore(state) {
			// 检查 ID 是否存在
			if(localStorage.getItem('store')) {
				// 如果存在，则使用本地缓存中的值替换当前配置
				this.replaceState(
					Object.assign(state, JSON.parse(localStorage.getItem('store')))
				);
			}
		}
	},
})


// 订阅 store 变更
store.subscribe((mutation, state) => {
	// 每次变更，均实时保存到本地缓存中，需要 string 
	localStorage.setItem('store', JSON.stringify(state));
});

export default store