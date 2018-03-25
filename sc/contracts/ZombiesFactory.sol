pragma solidity ^0.4.19;

/*
----------------游戏说明-------------
生成僵尸，僵尸有DNA 
1. 随机产生DNA （044040502344033），DNA长度为16位。
2. 根据DNA，显示不同造型的僵尸 （发型、肤色、衣服、鞋子）

在线游戏地址：https://cryptozombies.io
 */

//  ZombiesFactory 僵尸生产合约
contract ZombiesFactory {
    // 事件是区块链合约执行和链外联系的一个通道，通过这个通道，
    // 如果外部有监听这个事件，就能在调用事件后被触发监听（节点收到包含该交易的区块后）。
    event NewZombie(string name,uint dna,uint counts);

    // 僵尸DNA长度（永久保存在区块链中）
    // 状态机，账户状态，在合约账户状态中永久存储此状态变量信息。
    // 所以变更都会在历史区块链中被记录下来。
    //  uint 代表无符号的整数类型，其类型有多种不同长度的定义：uint8，uint16，uint32.... uint256
    // uint 就是 uint256 ，下面一行等同：
    //      uint256 dnaDigits = 16 ;
    uint dnaDigits = 16 ;

    // 835628104928473700000033333
    // 算术： 
    //  细节见： http://solidity.readthedocs.io/en/latest/types.html#integers
    // 特别： 平方： ** ，如： a**b ，则表示 a 的 b 次方。
    // 用于dna计算取余 ，如  dnaValue % dnaMoudles 得到一个16位数
    uint dnaMoudles = 10 ** dnaDigits;

    // 僵尸信息 结构
    // 结构是包含了一组数据类型的用户自定义数据类型。
    struct Zombie {
        // 僵尸的名字，字符串类型，任意长度：name="莉莉"，name='张三'，O(∩_∩)O~
        string name ; 
        uint dna;
    }

    //用数组去存放一批相同数据类型的数据。数据就是数组的元素。
    //数组： 分静态类型和动态类型
    //    静态类型：  Type[length] ，如： string[3]。 byte[3] ，可以提前确定元素个数的时候，优先使用。
    //    动态类型：  Type[] ， 如： string[]  ,无法提前预知元素个数时使用。
    //公开可访问的游戏中的所有僵尸。
    // 对于公开的状态变量，Solidity 会自动在编译的时候，帮你实现一个内置的取值函数，名为zomites
    //  如：  function zombies() returns([]bytes){return zombies;}
    Zombie[] public zombies; 
 
    // 私有private 函数：创建僵尸
    function _createZombies(string _name,uint _dna ) private {
        // 创建一只僵尸
        Zombie memory newZombie = Zombie(_name,_dna);
        // 并保存到数组。 
        uint len= zombies.push(newZombie);
        // 调用事件，实际上是在区块链中记录了一个日志，当节点收到区块后，可以自动发信这些特殊的日志，
        // 可实时通知外部，如Dapp。
        NewZombie(_name,_dna,len);
    } 
     
    // 根据_name 随机生成一个dna值。 
    function _generateRandomDna(string _name) private view returns (uint) {
        //根据 _name 随机产生一个随机数
        //  keccak256 理解为 SHA256 的加密函数：细微的_name 值变化，结果是大不相同。 
        //  keccak256 随机的结果是在矿工出单元时执行的，一般只用于伪随机，不能作为完全可靠的随机源。 
        bytes32 value = keccak256(_name);
        // 因为不同类型不能直接进行运算，所以必须显示类型转换。
        // 转换后，进行 取余 运算，获得一个固定长度的值。
        // 例如： 345678 % (10^3) = 345678 % 1000 = 678
        // 如果往大数值转可以自动转换，否则需要显示转换。
        // uint8 a =4;
        // uint32 b=5;
        // uint8 c= a+uint8(b);//因为 b 为 5 可以不丢失精度的情况下转换为：uint8

        return  uint(value) % dnaMoudles;
    }

    // 创建一只新的僵尸
    function createRandomZombie(string _name) public  {
        // 获得随机DNA
        uint rand=_generateRandomDna(_name);
        // 存储僵尸
        _createZombies(_name,rand);
    }
}

// 数组
/*
数组：
   uint[] numbers = new uint[];
   两个成员：
   1. lenght : 返回数组的长度
   2. push : 动态数组的一个函数，可以用于追加新的元素到数组的末尾处，并返回其新的长度值。
   numbers.length  //0 
   numbers.push(1);
   numbers.push(5);
   numbers.push(6);
   // number: [1,5,6] ，length=3


 */

/* 函数的修饰符
1. view 视图函数：保证函数内部不会修改合约的状态，但是可以读取状态变量，数据计算等。。
如：
    function getDngMouldes() public  view returns(uint ) {
        return dnaMoudles*2;
    }
2. pure 纯函数 ： 纯洁小妹妹，不会修改，也不会读取状态变量信息。
    function getSum(uint a,uintb ) public pure returns(uint) {
        return a+b;
    }
 */

/**
》固定长度的byte数组： bytesI
Bytes1,bytes2,bytes3....bytes32 , byte 是bytes1 的别名
通过元素下标访问元素： values[i] , i 的范围：[0,Len-1]

》动态长度的Byte数组：bytes ， 
 就有push的函数
 */