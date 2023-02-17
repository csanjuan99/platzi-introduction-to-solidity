// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Array {
    uint[3] numbers = [1, 2, 3];

    string[] names;


    function getElementInNumbers(uint index) public view returns(uint){
        return numbers[index];
    }

    function addNameToDinamicArray(string memory _name) public {
        names.push(_name);
    }

}