// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FunctionSelector {
    event Log(bytes data);
    event LogParams(address indexed _to, uint256 _amount);

    function transfer(address _to, uint256 _amount) external {
        emit LogParams(_to, _amount);
        emit Log(msg.data);
    }
}
