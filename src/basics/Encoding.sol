// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Encoding {
    function encodingString(
        string memory _text
    ) public pure returns (bytes memory) {
        return abi.encodePacked(_text);
    }

    /**
     * @dev Newer version of solidity we can use
     * string.contact(_str1,_str2);
     **/
    function contactString(
        string memory _str1,
        string memory _str2
    ) public pure returns (bytes memory) {
        return abi.encodePacked(_str1, _str2);
    }
}
