// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Permission {
    address private owner;
    string public project_name = "Tinca";

    constructor() {
        owner = msg.sender;
    }

    modifier owner_permission() {
        require(
            owner == msg.sender, 
            "Actualizar el proyeto solo es para el propietario."
        );
        // La funcion a modificar sera insertada en este simbolo, funciona como un decorador.
        _;  
    }

    function update(string memory _project_name) public owner_permission {
        project_name = _project_name;
    }
}