// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

/*
  1. sendpacket : Type (avg rand)
  2. stakepacket
*/
contract redpacket {

    bool rType;
    uint8 public rCount; // 红包数量
    uint256 public rTotalAmount; // 红包金额
    address payable public tuhao;
    mapping(address=>bool) isStake; // 记录抢过的用户

    constructor(bool isAvg, uint8 _count, uint256 _amount) payable {
        rType = isAvg;
        rCount = _count;
        rTotalAmount = _amount;
        tuhao = payable(msg.sender);
        require(msg.value == _amount, "redpacket's balance is invalid");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // 抢红包
    function stakePacket() public payable {
        require(rCount > 0, "red packet must > 0");
        require(getBalance() > 0, "contract's balance must enough");
        require(!isStake[msg.sender], "user already stake");

        isStake[msg.sender] = true;

        if(rType){
            // 等值
            uint256 amount = getBalance() / rCount;
            payable(msg.sender).transfer(amount);
        }else{
            // 随机
            if(rCount == 1){
                payable(msg.sender).transfer(getBalance());
            }else{
                uint256 randnum = uint256(keccak256(abi.encode(tuhao, rTotalAmount, rCount, block.timestamp, msg.sender))) % 10;
                uint256 amount = getBalance() * randnum / 10;
                payable(msg.sender).transfer(amount);
            }
        }
        rCount--;
    }

    function kill() public payable{
        selfdestruct(tuhao); // 内建函数，销毁合约
    }
}