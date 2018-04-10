<template>
 <v-layout justify-center>
    <v-flex xs12 sm10 md8 lg6>
      <v-form v-model="valid" ref="form" >
      <v-card> 
        <v-card-text>
          <span class="title">RPC 连接地址</span>
          <v-text-field  :value="rpc" ref="rpc" required  @input="afterInput"  :rules="rpcRules" 
          ></v-text-field>  
           <v-alert  outline :type="alert.type" :value="alert.msg">
             {{alert.msg}}
           </v-alert>
        </v-card-text> 
        <v-divider class="mt-5"></v-divider>
        <v-card-actions>
          <v-btn flat @click="testConn" :disabled="!valid" >测试连接</v-btn>
          <v-spacer></v-spacer>  
          <v-btn color="primary" flat @click="submit" :disabled="!valid">更新</v-btn>  
        </v-card-actions>
      </v-card> 
    </v-form>
    </v-flex>
    
  </v-layout>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import validate from "@/tools/validate";
import Web3 from "web3"; 

export default {
  data: () => ({
    valid: true, 
    rpcNow:"",
    rpcRules: [v => !!v || "必填", v => validate.isURL(v) || "URL格式错误"],
    alert: {
      type:'success', //成功与否
      msg: "" //需要显示的信息
    }
  }),
  computed: mapGetters({
    rpc: "rpc"
  }),
  created: function() {
    this.rpcReal = this.rpc;
  },

  methods: {
    ...mapMutations(["setRPC"]),
    afterInput() {
      this.alert.msg = ""; //关闭alert
      this.valid=this.$refs.form.validate()
      this.rpcNow= this.$refs.rpc.lazyValue 
    },
    submit() {
      if (this.$refs.form.validate()) {
        console.log(this.rpcNow)
        this.setRPC(this.rpcNow)
      }
    }, 
    testConn() {
      // 测试前，执行检查并清理Error
      this.afterInput();
      if (!this.valid){
        return
      }
      var _this = this;
      web3 = new Web3(new Web3.providers.HttpProvider(this.rpcNow));  
      web3.eth
        .getCoinbase() 
        .then(account => {
          _this.alert.type ='success';
          _this.alert.msg="成功获取到 Coninbase:\n"+ account
        })
        .catch(function(error) {
          _this.alert.type ='error';
          _this.alert.msg = error.message
        });
    }
  }
};
</script>
