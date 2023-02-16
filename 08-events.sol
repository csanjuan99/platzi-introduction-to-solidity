// SPDX-License-Identifier: GPL-3.0

// Los eventos permiten conectar lo que pasa en la blockchain con el exterior.
// a traves de un protocolo apps se pueden suscribir a dichos eventos.
// se usan para registrar cambios que se hicieron en el proyectos o dar feedback.
// por ejemplo si queremos enviar ether a una direccion, saber si se envio el ether o no.

pragma solidity >=0.7.0 <0.9.0;

contract Asset {
    string public token_name = "CryptoTinca";

    event change_name(
        address editor,
        string _token_name
    );

    function change_token_name(string memory _token_name) public {
        token_name = _token_name;
        emit change_name(msg.sender, _token_name);
    }
}