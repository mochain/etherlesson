// 这个配置文件和 truffle.js 一样，是 Window 下 truffle 加载配置。
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  // 该开发网络配置，来自 Ganache：http://truffleframework.com/ganache/
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777" // Match any network id
    }
  }
};
