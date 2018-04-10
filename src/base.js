
import contract from 'truffle-contract';
import Web3  from 'web3'; 

// web3 RPC通讯地址
// 应同文件 /sc/truffle.js 中一致。
const provider = "http://localhost:7545";
//  全局合约 ABI
//  所有ABI json 文件均在编译输出，如果缺失，则需要在 sc 目录下，运行 truffle complite 命令。
const globalContracts=new Map([ 
    ["Zombie","/static/contracts/ZombiesFactory.json"]
]); 

export default { 
    web3Provider: null,
    install:function(Vue,options){
       this.initWeb3();
       this.initContract(Vue);
    },
    // 初始化 web3
    initWeb3: function () {
        // 检查是否有 web3 全局变量，如果有，则使用此信息
        if (typeof web3 !== 'undefined') {
          this.web3Provider = web3.currentProvider;
        } else {
          // 如果缺失，则设置为默认
          this.web3Provider = new Web3.providers.HttpProvider(provider);
          web3 = new Web3(this.web3Provider); 
        }
    },
    // 初始化加载合约
    initContract:function(Vue){
        if (Vue.prototype.contracts ==undefined ){
            Vue.prototype.contracts={};
        }
        let _this=this;
        globalContracts.forEach(function(value,key){ 
            Vue.http.get(value).then((resouce) =>{  
                // 获取合约ABI文件，并将其实例化为可直接交换的合约示例 
                var c = contract(resouce.body);
                c.setProvider(_this.web3Provider);
                Vue.prototype.contracts[key] =c;
                //在合约加载完成后，事件通知外部，值为合约名称
                console.log("load contract:",key);
                Vue.bus.emit('contract-loaded',{name:key,contract:c}); 
            }).catch(function(response) {
                if (response.status==404){ 
                    alert("未找到合约ABI文件："+response.url);
                }
                console.log(response)
            });
        })
    }
};  ;