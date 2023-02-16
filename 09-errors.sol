// SPDX-License-Identifier: GPL-3.0
// Los errores son importantes porque nos ayudan a capturar comportamientos que no queremos en
// nuestros contratos
// Ademas da feedback a quien llama a nuestro contrato para indicar que esta haciendo mal
// En solidity cuando lanzamos un error los valores modificados hasta el punto vuelven a su estado anterior.
// pero el gas que se gasta en la transaccion no se devuelve a quien llama al contrato.


pragma solidity >=0.7.0 <0.9.0;

contract Asset {
    string public state = 'onSale';

    error StateNotDefined(uint _state);

    function changeState(uint _state) public {
        if(_state == 0) {
            state = 'onSale';
        } else if(_state == 1) {
            state = 'notForSale';
        } else {
            revert StateNotDefined(_state);
        }
    }
}