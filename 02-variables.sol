// SPDX-License-Identifier: GPL-3.0

// block.gaslimit limite de gas del bloque
// msg.data informacion de la llamada
// msg.sender informacion del remitente
// msg.value valor de wei enviado
// tx.gasprice cost en gas de la transaccion

pragma solidity >=0.7.0 <0.9.0;

contract Identity {
    uint256 public id;
    string public name;
    string public lastname;
    bool public working;
    address public wallet;

    constructor(uint _id, string memory _name, string memory _lastname, bool _working) {
        id = _id;
        name = _name;
        lastname = _lastname;
        working = _working;
        wallet = msg.sender;
    }
}