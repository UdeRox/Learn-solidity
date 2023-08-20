// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FallBackFunction {
    event Log(string indexed fun, address indexed sender, uint256 value);

    //@dev Notice there is no "function" key word in the fallback,
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value);
    }
    //@Ødev Notice there is no "function" key workd infront of the recevie
    receive() external payable {
        emit Log("Recieve", msg.sender, msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance; 
    }
}
