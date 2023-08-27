// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DelegateCall} from "./DelegateCall.sol";

contract ProxyDelegateContract {
    uint256 public s_numberCounter;

    function deligateAdd(DelegateCall _contract, uint256 _number) public {
        bytes memory callData = abi.encodeWithSignature(
            "add(uint256)",
            _number
        );
        (bool ok, ) = address(_contract).delegatecall(callData);
        if (ok) revert("Delegate call failed!");
    }
}
