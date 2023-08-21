// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test, console} from "forge-std/Test.sol";
import {FallBackFunction} from "../src/FallBackFunction.sol";

contract FallBackFunctionTest is Test {
    FallBackFunction fallbackFunction;
    address sender = makeAddr("sender");
    event Log(string indexed fun, address indexed sender, uint256 value);

    function setUp() public {
        vm.startBroadcast();
        fallbackFunction = new FallBackFunction();
        vm.stopBroadcast();
        sender = makeAddr("sender");
    }

    function testFallbackFunction() public payable {
        vm.prank(sender);
        vm.deal(sender, 10 ether);
        vm.expectEmit(true, true, false, true, address(fallbackFunction));
        emit Log("fallback", sender, 1 ether);
        payable(address(fallbackFunction)).call{value: 1 ether}("0x1223");
    }

    function testReceiveFunction() public {
        vm.prank(sender);
        vm.deal(sender, 10 ether);
        vm.expectEmit(true, true, false, true, address(fallbackFunction));
        emit Log("Recieve", sender, 1 ether);
        payable(address(fallbackFunction)).transfer(1 ether);
    }
}
