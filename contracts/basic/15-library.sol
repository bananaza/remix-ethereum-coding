// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

import "./libstring.sol";

contract library_demo {
    // 声明
    using libstring for string;

    function testEqual(string memory a, string memory b) public pure returns (bool){
        return a.isEqual(b); // isEqual(a,b)
    }
}