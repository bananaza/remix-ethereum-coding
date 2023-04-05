// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract money_demo{
    address public admin;
    address payable public user;
    uint256 totalAmount;

    constructor(address _owner){
        admin = _owner;
    }

    function deposit(uint256 _amount) public payable{

        // totalAmount是账面上的钱，不是实际的钱，以下操作可能会导致钱充值了，但是没记上帐
        if(_amount != msg.value) return;

        user = payable(msg.sender);  // 操作者
        totalAmount = _amount;

        // 下面这个步骤自动操作，不用添加
        // address(this).balance += _amount
    }

    function getBalance() public view returns(uint256, uint256){
        // this：合约本身
        // 账户余额
        return (address(this).balance, totalAmount);
    }

    function withdraw(uint256 _amount) public payable{
        user.transfer(_amount);
    }
}