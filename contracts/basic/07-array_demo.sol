// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

/*
    names:["zhangsan","lisi"]
    ages:[20,30]
*/

contract array_demo{
    string[5] public names;
    uint8[] public ages;

    constructor(){
        names[0] = "zhangsan";
        names[1] = "lisi";

        // ages[0] = 20;
        // ages[1] = 30;
        ages.push(20); // 需要对不定长数组使用push，否则报错
    }

    function addAge(uint8 _age) public {
        ages.push(_age);
    }

    function getLength() public view returns (uint256, uint256){
        return (names.length, ages.length);
    }

    // function addName(string memory _name) public {
    //     names.push(_name);
    // }
}