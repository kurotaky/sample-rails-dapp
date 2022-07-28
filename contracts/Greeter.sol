// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract Greeter {
    string name;

    function setName(string calldata _name) public {
        name = _name;
    }

    function hello() public view returns (string memory) {
        return string(string.concat("Hello ", name));
    }
}
