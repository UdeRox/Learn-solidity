// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test, console} from "forge-std/Test.sol";
import {FunctionSelector} from "../src/FunctionSelector.sol";

contract FunctionSelectorTest is Test {
    FunctionSelector public functionSelector;
    address sender = makeAddr("sender");
    address reciever = makeAddr("reciever");
    uint256 public constant TRANSFER_AMOUNT = 1 ether;
    uint256 public constant INITIAL_AMOUNT = 10 ether;

    event Log(bytes data);

    function setUp() public {
        vm.startBroadcast();
        functionSelector = new FunctionSelector();
        vm.stopBroadcast();
    }

    function testFunctionSelect() public {
        // 0xa9059cbb
        //00000000000000000000000053e3b1892d56d0752870bc284499c3671c74304c
        //0000000000000000000000000000000000000000000000000de0b6b3a7640000
        vm.expectEmit(false, false, false, false, address(functionSelector));
        emit Log(msg.data);
        functionSelector.transfer(reciever, TRANSFER_AMOUNT);
    }
}
