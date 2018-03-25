
//  pragma 编译指令（杂注指令）
//  告诉编译器(solc)，【如何】编译源文件
//  ^0.4.19 --> npm 版本依赖表达式格式
//  solc version can complite : [0.4.19,0.5)
pragma solidity ^0.4.19;

//  定义了一个名为 Migrations 的合约
//  合约相对于面向对象中的类（Class）OO
//  Class        Solidity智能合约
//      字段 （属性，特征）       状态变量 -- 会保存在区块链中，对外公开访问，透明  -- 存储 -- 资源  -- 很高的成本
//      函数（行为）   
//      事件 （行为，被触发）
//     构造函数（初始化对象时new，不允许实例重复调用）      构造函数（在区块链上部署合约时执行）
// 
//  Contract Code  不包含 构造合约的代码。 
//  在你部署合约，发送该交易的时候：Tx {from:'',value:'',data:'0x6060...' }
// 
contract Migrations {
  // 定义了一个公开的 address 类型的状态变量 owner
  address public owner;
  // 定义了一个公开的 uint 类型的状态变量  last_completed_migration
  uint public last_completed_migration;

  // 修改器，改变函数执行的行为
  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function Migrations() public {
    owner = msg.sender;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}