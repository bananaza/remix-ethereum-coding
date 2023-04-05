// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract func_demo{
    function getSum() public view returns(uint256){
        uint256 sum = 0;
        for(uint256 i = 1; i <= 100; i++){
            sum += i;
        }
        return sum;
    }

    function getSum2() public view returns(uint256 sum){
        uint256 i = 0;
        while(i <= 100){
            sum += i;
            i++;
        }
    }

    function isEqual(string memory a, string memory b) public view returns(bool){
        // return a == b;
        bytes32 hashA = keccak256(abi.encode(a));
        bytes32 hashB = keccak256(abi.encode(b));
        return hashA == hashB;
    }
}