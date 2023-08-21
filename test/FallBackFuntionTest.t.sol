// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test, console} from "forge-std/Test.sol";
import {FallBackFunction} from "../src/FallBackFunction.sol";

contract FallBackFunctionTest is Test {
    FallBackFunction fallbackFunction;
    address sender = makeAddr("sender");
    uint256 public constant TRANSFER_AMOUNT = 1 ether;
    event Log(string indexed fun, address indexed sender, uint256 value);

    function setUp() public {
        vm.startBroadcast();
        fallbackFunction = new FallBackFunction();
        vm.stopBroadcast();
        sender = makeAddr("sender");
    }

    function testFallbackFunction() public {
        vm.prank(sender);
        vm.deal(sender, 10 ether);
        vm.expectEmit(true, true, false, true, address(fallbackFunction));
        emit Log("fallback", sender, TRANSFER_AMOUNT);
        (bool sent, ) = payable(address(fallbackFunction)).call{
            value: TRANSFER_AMOUNT
        }("0x");
        assertEq(sent, true);
        assertEq(fallbackFunction.getBalance(), TRANSFER_AMOUNT);
    }

    function testReceiveFunction() public {
        vm.prank(sender);
        vm.deal(sender, 10 ether);
        vm.expectEmit(true, true, false, true, address(fallbackFunction));
        emit Log("Recieve", sender, TRANSFER_AMOUNT);
        payable(address(fallbackFunction)).transfer(TRANSFER_AMOUNT);
        assertEq(fallbackFunction.getBalance(), TRANSFER_AMOUNT);
    }
}
