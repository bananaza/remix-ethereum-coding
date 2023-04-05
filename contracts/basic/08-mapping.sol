// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

contract mapping_demo {
    // student's math score
    mapping(string=>uint256) m;

    function addScore(string memory _name, uint256 _score) public {
        m[_name] = _score;
    }

    function getScore(string memory _name) public view returns(uint256){
        return m[_name];
    }
}