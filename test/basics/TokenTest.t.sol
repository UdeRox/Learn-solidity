// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../../src/basics/Token.sol";

contract TokenTest is Test {
    uint256 public TOTOAL_SUPPLY = 100;
    Token token;
    address alice = makeAddr("Alice");
    address owner = makeAddr("Owner");

    function setUp() public {
        vm.startBroadcast();
        token = new Token(TOTOAL_SUPPLY);
        vm.stopBroadcast();
        // vm.prank(owner);
    }

    function testOwenrCanMint() public {
        vm.prank(msg.sender);
        token.mint(alice, 1 ether);
        assertEq(token.s_balanceOf(alice), 1 ether);
    }

    /**
     * @dev for the inspection of memory slot, we can use forge command
     * forge inspect Token storage --pretty
     */
    function testStorgeIndex() public {
        bytes32 aliceBalanceSlot = keccak256(
            abi.encodePacked(uint256(uint160(alice)), uint256(0))
        );
        vm.prank(msg.sender);
        token.mint(alice, 1 ether);
        uint256 aliceBalance = uint256(
            vm.load(address(token), aliceBalanceSlot)
        );
        assertEq(aliceBalance, token.s_balanceOf(alice));
    }
}
