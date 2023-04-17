// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;


contract bank_demo {
    string public bankName;     // 名称
    uint256 totalAmount;        // 总存款余额
    address public admin;
    mapping(address=>uint256) balances; // 用户余额查询

    constructor(string memory _name){
        bankName = _name;
        admin = msg.sender;
    }

    function getBalance() public view returns(uint256, uint256){
        return(address(this).balance, totalAmount);
    }

    // 存款
    function deposit(uint256 _amount) public payable{
        require(_amount > 0, "amount must bigger than zero.");
        require(msg.value == _amount, "msg.value must equal amount");
        balances[msg.sender] += _amount;
        totalAmount += _amount;
        require(address(this).balance == totalAmount, "bank's balance must ok");
    }

    function withdraw(uint256 _amount) public payable{
        require(_amount > 0, "amount must bigger than zero.");
        require(balances[msg.sender] >= _amount, "user's balance not enough");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        totalAmount -= _amount;
        require(address(this).balance == totalAmount);
    }

    // from = msg.sender
    function transfer(address _to, uint256 _amount) public{
        require(_amount > 0, "amount must bigger than zero.");
        require(address(0) != _to, "to address must valid");
        require(balances[msg.sender] >= _amount, "user's balance not enough");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        require(address(this).balance == totalAmount, "bank's balance must ok");
    }

    function balanceOf(address _who) public view returns(uint256){
        return balances[_who];
    }
}