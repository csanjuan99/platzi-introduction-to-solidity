// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFundingProject {

    enum State { Open, Closed }

    struct Project {
        string name;
        State status;
        uint256 goal;
        uint256 funded;
        address payable owner;
    }

    Project public project;

    event event_status(
        address _owner,
        State _status
    );

    event event_funding(
        address _sender,
        uint256 _value,
        uint256 _funded
    );

    constructor(string memory _name, State _status, uint256 _goal) {
        project = Project(_name, _status, _goal, 0, payable(msg.sender));
    }

     modifier owner_permission() {
        require(
            project.owner == msg.sender,
            "Actualizar el proyeto solo es para el propietario."
        );
        // La funcion a modificar sera insertada en este simbolo, funciona como un decorador.
        _;
    }

    modifier owner_fund() {
        require(project.owner != msg.sender, "El propietario no puede agregar dinero a su proyecto.");
        _;
    }

    function fundProject() public payable owner_fund {
        require(project.status == State.Open, "No se aceptan mas entradas de dinero.");
        require(project.funded != project.goal, "Ya se llego a la meta, no se necesita mas dinero.");
        require(msg.value != uint(0), "Agregue dinero al proyecto.");
        require(project.funded+msg.value <= project.goal, "No se puede agregar mas dinero que la meta.");
        project.funded = project.funded + msg.value;
        project.owner.transfer(msg.value);
        emit event_funding(msg.sender, msg.value, project.funded);
    }

    function chageProjectState(State _status) public owner_permission {
        project.status = _status;
        emit event_status(msg.sender, _status);
    }

}

contract CrowdFundingProjects {
    enum FundraisingState {
        Opened,
        Closed
    }

    struct Contribution {
        address contributor;
        uint256 value;
    }

    struct Project {
        string id;
        string name;
        string description;
        address payable author;
        FundraisingState state;
        uint256 funds;
        uint256 fundraisingGoal;
    }

    Project[] public projects;
    mapping(string => Contribution[]) public contributions;

    event ProjectCreated(
        string projectId,
        string name,
        string description,
        uint256 fundraisingGoal
    );

    event ProjectFunded(string projectId, uint256 value);

    event ProjectStateChanged(string id, FundraisingState state);

    modifier isAuthor(uint256 projectIndex) {
        require(
            projects[projectIndex].author == msg.sender,
            "You need to be the project author"
        );
        _;
    }

    modifier isNotAuthor(uint256 projectIndex) {
        require(
            projects[projectIndex].author != msg.sender,
            "As author you can not fund your own project"
        );
        _;
    }

    function createProject(
        string calldata id,
        string calldata name,
        string calldata description,
        uint256 fundraisingGoal
    ) public {
        require(fundraisingGoal > 0, "fundraising goal must be greater than 0");
        Project memory project = Project(
            id,
            name,
            description,
            payable(msg.sender),
            FundraisingState.Opened,
            0,
            fundraisingGoal
        );
        projects.push(project);
        emit ProjectCreated(id, name, description, fundraisingGoal);
    }

    function fundProject(uint256 projectIndex)
        public
        payable
        isNotAuthor(projectIndex)
    {
        Project memory project = projects[projectIndex];
        require(
            project.state != FundraisingState.Closed,
            "The project can not receive funds"
        );
        require(msg.value > 0, "Fund value must be greater than 0");
        project.author.transfer(msg.value);
        project.funds += msg.value;
        projects[projectIndex] = project;

        contributions[project.id].push(Contribution(msg.sender, msg.value));

        emit ProjectFunded(project.id, msg.value);
    }

    function changeProjectState(FundraisingState newState, uint256 projectIndex)
        public
        isAuthor(projectIndex)
    {
        Project memory project = projects[projectIndex];
        require(project.state != newState, "New state must be different");
        project.state = newState;
        projects[projectIndex] = project;
        emit ProjectStateChanged(project.id, newState);
    }
}
