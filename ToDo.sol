//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ToDo {
    address public owner;
    uint256 taskCount; 

    mapping (address => uint256[]) tasks;

    event TaskCreated (address user, uint256 task);
    event TaskCompleted(uint256 taskId);

    struct Task {
        uint256 taskId;
        address user;
        string title;
        string description;
        bool doneStatus;
    }

    constructor() {
        owner = msg.sender;
    }

    function createTask (uint256 _taskId, string memory _title, string memory _description) external {
        taskCount++;
        
        Task memory newTask= Task(_taskId,msg.sender, _title, _description, false);
        newTask.user = msg.sender;
        newTask.title = _title;
        newTask.description = _description;
        newTask.doneStatus = false;

        tasks[msg.sender].push(taskCount);

        emit TaskCreated (msg.sender, taskCount);
    }


    function getUserTasks () external view returns (uint256[] memory) {
        return tasks[msg.sender];
    }
}