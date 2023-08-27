// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DelegateCall {
    uint256 public s_numberCounter;

    // constructor() {}

    function add(uint256 _number) public {
        require(_number < 5, "Number must be less than 5 and grater than 0");
        s_numberCounter += _number;
    }
}
