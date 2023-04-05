// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract var_demo {
    // world state
    string public authName;
    uint8 public authorAge;
    uint256 authorSalary;
    bytes32 public authorHash;

    // 构造函数
    constructor(string memory _name, uint8 _age, uint256 _salary){
        authName = _name;
        authorAge = _age;
        authorSalary = _salary;
        // 计算哈希
        authorHash = keccak256(abi.encode(_name, _age, _salary));
    }
}