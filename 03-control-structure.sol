// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Person {
    bool public skinBlock;

    constructor(bool _skinBlock) {
        skinBlock = _skinBlock;
    }

    function skinStatus() public view returns(bool skin) {
        if(skinBlock) {
            skin = false;
        } else {
            skin = true;
        }
    }
}