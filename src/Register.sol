// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Register {
    //creating array with type of address, named to users.
    address[25] public users;
    uint256 public userSize;

    event UserRegisterd (address indexed user, address indexed sender);

    constructor(){
        userSize=0;
    } 

    function register(address _newUser) public {
        require(userSize < 25, "Only 25 Users can register!");
        users[userSize]= _newUser;
        userSize++;
        //emiting User Registerd event.
        emit UserRegisterd(_newUser, msg.sender);
    }

}
