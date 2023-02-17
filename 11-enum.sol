// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Enum {
    enum State { Active, Inactive }

    struct User {
        State state;
    }

    User public user;

    constructor() {
        user = User(State.Inactive);
    }

    function getUserState() public view returns(State){
        return user.state;
    }
}