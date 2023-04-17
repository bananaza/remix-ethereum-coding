// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

struct Player {
    address addr;    // 地址
    uint256 amount;  // 金额
}

contract bocai {

    Player[] bigs;
    Player[] smalls;
    uint256 public totalBigAmount;
    uint256 public totalSmallAmount;
    address public owner;
    bool public isFinished;
    uint256 minBetAmount;
    uint256 public endTime;

    constructor(uint256 _minAmount){
        owner = msg.sender;
        isFinished = false;
        minBetAmount = _minAmount;
        endTime = block.timestamp + 1200; // 1200秒
    }
    
    // true为大，false为小
    function bet(bool isBig) public payable {
        require(!isFinished, "Game is finished");
        require(msg.value >= minBetAmount, "Bet's amount must > min");
        require(block.timestamp < endTime, "Over Time!");


        Player memory player = Player(msg.sender, msg.value);
        if(isBig){
            // Big
            bigs.push(player);
            totalBigAmount += msg.value;
        }else{
            // Small
            smalls.push(player);
            totalSmallAmount += msg.value;
        }
    }

    function open() public payable {
        require(!isFinished, "Game is finished");
        require(block.timestamp < endTime, "Over Time!");

        // [0-17] => small:0~8 big:9~17
        uint256 random = uint256(keccak256(abi.encode(block.timestamp, msg.sender, owner))) % 18;
        if(random <= 8){
            // small
            for(uint256 i = 0; i < smalls.length; i++){
                Player memory player = smalls[i];
                uint256 bonus = player.amount + totalBigAmount * player.amount / totalSmallAmount * 90 / 100; // 抽成
                payable(player.addr).transfer(bonus);
            }
            payable(owner).transfer(totalBigAmount * 10 / 100);
        }else{
            // big
            for(uint256 i = 0; i < bigs.length; i++){
                Player memory player = bigs[i];
                uint256 bonus = player.amount + totalSmallAmount * player.amount / totalBigAmount * 90 / 100; // 抽成
                payable(player.addr).transfer(bonus);
            }
            payable(owner).transfer(totalSmallAmount * 10 / 100);
        }
    }

    function getBalance() public view returns(uint256, uint256){
        return (address(this).balance, totalSmallAmount + totalBigAmount);
    }

    function getNow() public view returns(uint256){
        return block.timestamp;
    }
}