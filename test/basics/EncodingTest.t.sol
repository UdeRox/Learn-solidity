// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Encoding} from "../../src/basics/Encoding.sol";

contract EncodingTest is Test {
    Encoding encoding;

    function setUp() public {
        vm.startBroadcast();
        encoding = new Encoding();
        vm.stopBroadcast();
    }

    function testEncoding() public {
        string memory text = "Hello Solidity!";
        //byets and abi.encodedPacked() are nealy idential but machanism is differerent
        bytes memory passedText = bytes(text);
        bytes memory returnBytes = encoding.encodingString(text);
        assertEq(abi.encodePacked(passedText), returnBytes);
    }

    function testStringConcatination() public {
        string memory str1 = "Hello";
        string memory str2 = "Solidity!";
        bytes memory returnBytes = encoding.contactString(str1, str2);
        assertEq(abi.encodePacked(str1, str2), returnBytes);
    }

    // function testDecoding () public {
    //     // uint32 number = 456798;

    // }
}
