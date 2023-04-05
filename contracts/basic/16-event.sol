// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract event_demo{
    address public admin;
    address payable public user;
    uint256 totalAmount;

    // event
    event Deposit(address who, uint256 amount);
    event Withdraw(address who,  address operator, uint256 amount);

    constructor(address _owner){
        admin = _owner;
    }

    function deposit(uint256 _amount) public payable{

        // 断言，不满足条件则回滚
        require(_amount == msg.value, "amount must equals msg.value");
        // assert(_amount > 0);

        // totalAmount是账面上的钱，不是实际的钱，以下操作可能会导致钱充值了，但是没记上帐
        if(_amount != msg.value) return;

        user = payable(msg.sender);  // 操作者
        totalAmount = _amount;

        emit Deposit(msg.sender, _amount);

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

        emit Withdraw(user, msg.sender, _amount);
    }
}