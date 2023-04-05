// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract modifier_demo{
    address public admin;
    uint256 public amount;

    constructor(){
        admin = msg.sender;
        amount = 101;
    }

    modifier onlyAdmin(){
        require(msg.sender == admin, "only admin can access");
        require(amount > 100, "amount must > 100");
        _;
    }

    function setMoney(uint256 _amount) public onlyAdmin{
        amount = _amount;
    }
}