// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ForLoop} from "../../src/YulFundamentals/ForLoop.sol";

contract FooLoopTest is Test {
    ForLoop public forLoop;
    uint[] _array = [1,2,3];

    function setUp() public {
        vm.startBroadcast();
        forLoop = new ForLoop();
        vm.stopBroadcast();
    }

    function testForLoopSum1() public {
        uint256 result = forLoop.sumOfArrayYul1(_array);
        assertEq(result, 6);
    }

    function testForLoopSum2() public {
        uint256 result  = forLoop.sumOfArrayYul2(_array);
        assertEq(result, 6);
    }

    function testForLoopSum3() public {
        uint256 result = forLoop.sumOfArrayYul3(_array);
        assertEq(result,6);
    }

    function testForLoopSum4() public {
        uint256 result = forLoop.sumOfArrayYul4(_array);
        assertEq(result,6);
    }

    function testForLoopSum() public {
        uint256 result = forLoop.sumOfArraySol(_array);
        assertEq(result,6);
    }
}
