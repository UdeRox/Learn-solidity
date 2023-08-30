// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title DelegateCall
 * @author UdeRox
 * @notice 
 */
contract DelegateCall {
    uint256 public s_numberCounter;

    function add(uint256 _number) public {
        require(_number < 5, "Number must be less than 5 and grater than 0");
        s_numberCounter += _number;
    }

    function getNumberCounter() public view returns (uint256) {
        return s_numberCounter;
    }
}
