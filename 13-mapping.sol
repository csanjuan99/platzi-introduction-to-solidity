//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Mapping {

    mapping(string => string) private countries;

    function get(string memory _country) public view returns (string memory) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return countries[_country];
    }

    function set(string memory _country, string memory _i) public {
        // Update the value at this address
        countries[_country] = _i;
    }

    function remove(string memory _country) public {
        // Reset the value to the default value.
        delete countries[_country];
    }

}