// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract auction {

    address payable owner;     // 平台方
    address payable seller;    // 卖方
    address payable buyer;     // 最高价买方
    uint256 public highestBid; // 最高价
    uint256 public startBid;   // 起拍价
    uint256 public endTime;    // 结束时间
    bool isFinished;

    event BidEvent(address _buyer, uint256 _highestBid);
    event EndEvent(address _buyer, uint256 _highestBid);

    constructor(address _seller, uint256 _startBid){
        owner = payable(msg.sender);
        seller = payable(_seller);
        startBid = _startBid;
        isFinished = false;
        endTime = block.timestamp + 600;
        highestBid = 0;
    }

    function bid(uint256 _amount) public payable {
        require(_amount == msg.value, "amount must equals msg.value!");
        require(_amount > highestBid, "amount must > highestBid");
        require(!isFinished, "auction already finished");
        require(block.timestamp < endTime, "over time");

        if(address(0) != buyer){
            // 退钱
            buyer.transfer(highestBid);
        }
        
        highestBid = _amount;
        buyer = payable(msg.sender);
        emit BidEvent(buyer, highestBid);
    }

    function endAuction() public payable {
        require(!isFinished, "auction already finished");
        require(msg.sender == owner, "only owner can end");
        isFinished = true;

        seller.transfer(highestBid * 90 / 100);
        owner.transfer(highestBid * 10 / 100);

        emit EndEvent(buyer, highestBid);
    }
}
