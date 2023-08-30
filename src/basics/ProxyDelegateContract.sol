// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DelegateCall} from "./DelegateCall.sol";

/**
 * @title ProxyDelegateContract
 * @author @udeRox 
 * @notice 
 */
contract ProxyDelegateContract {
    uint256 public s_numberCounter;

    function deligateAdd(DelegateCall _contract, uint256 _number) public {
        // @dev here uses abi.encodeWithSignature convert the function selector and parameter to calldata.
        bytes memory callData = abi.encodeWithSignature(
            "add(uint256)",
            _number
        );
        // @dev calls 'add' using delegatecall, pass 'callData' as parameter 
        // call deta frist 4 bytes is the function selector and rest will be parameters.  
        (bool ok, ) = address(_contract).delegatecall(callData);
        if (!ok) revert("Delegate call failed!");
    }

    function getPxyNumberCounter() public view returns (uint256) {
        return s_numberCounter;
    }
}
