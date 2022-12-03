//注意：所有语句结束要加；和python不一样

//solidity的代码要先声明版本
pragma solidity ^0.4.19;
//然后创建一个合约的外壳
contract ZombieFactory {
    //这里声明一个事件，是区块链中合约监听的一种方式，NewZombie之后会在_createZombie中触发
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    //定义一个结构体
    struct Zombie {
        string name;
        uint dna;
    }
    //实例化一个结构体序列
    Zombie[] public zombies;
    //如果定义一个function为private，要在参数后面加上private，然后把函数的名称前加上下划线_；
    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1; //给zombies这个序列中append一个结构体数据，传入参数_name和_dna
        NewZombie(id, _name, _dna);//这里出发事件event
    }
    //如果函数没有改变任何值和状态，用view去修饰函数，否则用pure ？？？
    //return要声明 数据类型
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));//用算法keccak256映射哈希值
        return rand % dnaModulus;
    }
    //public return不需要声明
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);//行为函数
    }

}
