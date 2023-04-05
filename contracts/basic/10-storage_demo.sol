// SPDX-License-Identifier: Apache-2.0
pragma solidity^0.8.7;

struct User{
    string name;
    uint8 age;
    string sex;
}

contract storage_demo{
    User adminUser;
    function setUser(string memory _name, uint8 _age, string memory _sex) public {
        adminUser.name = _name;
        adminUser.age = _age;
        adminUser.sex = _sex;
    }
    function getUser() public view returns(User memory){
        return adminUser;
    }

    function setAge1(uint8 _age) public {
        User memory user = adminUser;
        user.age = _age;
    }

    function setAge2(uint8 _age) public {
        User storage user = adminUser;
        user.age = _age;
    }

    function setAge3(User storage _user, uint8 _age) internal {
        _user.age = _age;
    }

    function callsetAge3(uint8 _age) public {
        setAge3(adminUser, _age);
    }
}