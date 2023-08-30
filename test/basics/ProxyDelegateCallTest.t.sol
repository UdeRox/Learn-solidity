// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test, console} from "forge-std/Test.sol";
import {ProxyDelegateContract} from "../../src/basics/ProxyDelegateContract.sol";
import {DelegateCall} from "../../src/basics/DelegateCall.sol";

contract ProxyDelegateCallTest is Test {
    ProxyDelegateContract proxyDelegateContract;
    DelegateCall delegateCall;

    function setUp() public {
        vm.startBroadcast();
        delegateCall = new DelegateCall();
        proxyDelegateContract = new ProxyDelegateContract();
        vm.stopBroadcast();
    }

    function testProxyDelegateTest() public {
        assertEq(delegateCall.getNumberCounter(), 0);
        assertEq(proxyDelegateContract.getPxyNumberCounter(), 0);

        proxyDelegateContract.deligateAdd(delegateCall, 4);

        assertEq(delegateCall.getNumberCounter(), 0);
        assertEq(proxyDelegateContract.getPxyNumberCounter(), 4);
    }
}
