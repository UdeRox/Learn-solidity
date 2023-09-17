// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ForLoop {
    // Soldity function
    // Passing numbers array to the function, it returns the result as uint256.
    function sumOfArraySol(
        uint256[] memory _array
    ) public pure returns (uint256 result) {
        uint256 sizeOfArray = _array.length;

        for (uint256 i = 0; i < sizeOfArray; i++) {
            result += _array[i];
        }

        // return result;
    }

    // Soldity function
    // Passing numbers array to the function, it returns the result as uint256.
    function sumOfArrayYul1(
        uint256[] memory _array
    ) public pure returns (uint256 result) {
        // Here start the assembly block
        assembly {
            let sizeOfArray := mload(_array) //opcode - 'MLOAD'
            for {
                let i := 0
            } lt(i, sizeOfArray) {
                //opcode 'LT'
                i := add(i, 1) // opcode 'ADD'
            } {
                result := add(
                    result,
                    mload(add(add(_array, 0x20), mul(i, 0x20))) // opcode 'MUL'
                )
            }
        }
    }

    function sumOfArrayYul2(
        uint256[] memory _array
    ) public pure returns (uint256 result) {
        // Here start the assembly block
        assembly {
            let sizeOfArray := mload(_array)
            for {
                let i := 0
            } iszero(eq(i, sizeOfArray)) {
                i := add(i, 1)
            } {
                result := add(
                    result,
                    mload(add(add(_array, 0x20), mul(i, 0x20)))
                )
            }
        }
    }

    function sumOfArrayYul3(
        uint256[] memory _array
    ) public pure returns (uint256 result) {
        assembly {
            let sizeOfArray := mload(_array)
            let end := add(add(_array, 0x20), mul(sizeOfArray, 0x20))
            for {
                let i := add(_array, 0x20)
            } lt(i, end) {
                i := add(i, 0x20)
            } {
                result := add(result, mload(i))
            }
        }
    }

    function sumOfArrayYul4(
        uint256[] memory _array
    ) public pure returns (uint256 result) {
        assembly {
            let sizeOfArray := mload(_array)
            let dataPointer := add(_array, 0x20) // Start of the data in memory

            for {
                let i := 0
                // } lt(i, sizeOfArray) {
            } iszero(eq(i, sizeOfArray)) {
                i := add(i, 1)
            } {
                // Calculate the memory location of the i-th element
                let element := mload(dataPointer)

                // Add the element to the result
                result := add(result, element)

                // Move the data pointer to the next element
                dataPointer := add(dataPointer, 0x20) // Move by 32 bytes
            }
        }
    }
}
