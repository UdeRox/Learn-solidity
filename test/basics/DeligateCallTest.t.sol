// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DelegateCall} from "../../src/basics/DelegateCall.sol";

contract DeligateCallTest is Test {
    DelegateCall delegateContract;

    function setUp() public {
        vm.startBroadcast();
        delegateContract = new DelegateCall();
        vm.stopBroadcast();
    }

    function testDeligateCall() public {
        delegateContract.add(4);
        assertEq(delegateContract.s_numberCounter(), 4);
    }
}
