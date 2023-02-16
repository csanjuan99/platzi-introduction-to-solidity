// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Crowdfunding {

    string public project_name;
    bool public status;
    uint256 public goal;
    uint256 public funded;
    address payable public owner;

    constructor(string memory _project_name, bool _status, uint256 _goal) payable {
        project_name = _project_name;
        status = _status;
        goal = _goal;
        funded = 0;
        owner = payable(msg.sender);
    }

    event event_status(
        address _owner,
        bool _status
    );

    event event_funding(
        address _sender,
        uint256 _value,
        uint256 _funded
    );

     modifier owner_permission() {
        require(
            owner == msg.sender, 
            "Actualizar el proyeto solo es para el propietario."
        );
        // La funcion a modificar sera insertada en este simbolo, funciona como un decorador.
        _;  
    }

    modifier owner_fund() {
        require(owner != msg.sender, "El propietario no puede agregar dinero a su proyecto.");
        _;
    }

    function fundProject() public payable owner_fund {
        require(status, "No se aceptan mas entradas de dinero.");
        require(funded != goal, "Ya se llego a la meta, no se necesita mas dinero.");
        require(msg.value != uint(0), "Agregue dinero al proyecto.");
        require(funded+msg.value <= goal, "No se puede agregar mas dinero que la meta.");
        funded = funded + msg.value;
        owner.transfer(msg.value);
        emit event_funding(msg.sender, msg.value, funded);
    }

    function chageProjectState(bool _status) public owner_permission {
        status = _status;
        emit event_status(msg.sender, _status);
    }
}