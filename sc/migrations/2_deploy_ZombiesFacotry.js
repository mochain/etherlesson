var ZombiesFactory = artifacts.require("./ZombiesFactory.sol");

module.exports = function(deployer) {
  // 部署合约
  deployer.deploy(ZombiesFactory);
};
