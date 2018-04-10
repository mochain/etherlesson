<template>
  <v-app id="inspire">
    <v-navigation-drawer  fixed  :clipped="$vuetify.breakpoint.lgAndUp"
      app   v-model="drawer"  class="grey lighten-4"
    >
      <v-list dense >
        <template v-for="(item, i) in items">
          <v-layout  row  v-if="item.heading"   align-center  :key="i" >
            <v-flex xs6>
              <v-subheader v-if="item.heading">
                {{ item.heading }}
              </v-subheader>
            </v-flex>
            <v-flex xs6 class="text-xs-right">
              <v-btn small flat>edit</v-btn>
            </v-flex>
          </v-layout>
          <v-divider  dark    v-else-if="item.divider"  class="my-3"  :key="i" ></v-divider>
          <v-list-tile   :key="i" v-else  @click="go(item.href)"  >
            <v-list-tile-action> 
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title class="grey--text">
                {{ item.text }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </template>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar
      color="green darken-2"
      dark
      app
      :clipped-left="$vuetify.breakpoint.lgAndUp"
      fixed
    >
      <v-toolbar-title  class="ml-0 pl-3">
        <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon> 
        <span class="hidden-sm-and-down" @click="go('/')">以太坊智能合约实战&nbsp;<small class="text">磨链区块链技术社区</small></span>
      </v-toolbar-title> 
      <v-spacer></v-spacer>
             <v-btn icon v-for="(nav,i) in toobars" :key="i"  :to="nav.href" >
     <v-icon>{{nav.icon}}</v-icon>  
   </v-btn> 
    </v-toolbar>
    <v-content>
      <v-container fluid fill-height> 
         <router-view></router-view>
      </v-container>
    </v-content> 
            <v-footer app  class="pa-3">
    <v-spacer></v-spacer>
     <div>&copy; {{ new Date().getFullYear() }}</div>
   </v-footer> 
  </v-app>
</template>

<script>
export default {
  name: "App",
  data: () => ({
    drawer: null,
    items: [
      { icon: "lightbulb_outline", text: "须知", href: "" },
      { icon: "touch_app", text: "视频教程", href: "" },
      { divider: true, href: "" },
      { icon: "settings", text: "设置", href: "/setting" },
      {
        icon: "chat_bubble",
        text: "交流",
        href: "https://gitter.im/mochain/etheraction"
      },
      {
        icon: "help",
        text: "帮助",
        href: "https://gitter.im/mochain/etheraction"
      }
    ],
    toobars: [{ icon: "assignment", href: "/contract/list" }]
  }),
  methods:{ 
    go: function(path){ 
      if (path.startsWith("/")) { 
       this.$router.push({path:path}) 
      }else{
        window.open(path) 
      }
    }
  }
};
</script>

<style>
#keep main .container {
  height: 660px;
}

.navigation-drawer__border {
  display: none;
}

.text {
  font-weight: 400;
}
</style>

