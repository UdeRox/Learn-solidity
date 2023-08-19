// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// import {ERC1155Burnable} from "@openzeppelin/contracts/token/ERC1155Burnable/ERC1155Burnable.sol";

contract Participants is ERC1155, Ownable {
    uint public constant PARTICIPANT = 0;
    uint public constant WINNER = 1;
    string public name = "Course Participant NFT";

    //Sets the base uri to mint initial tokens.
    constructor()
        ERC1155(
            "https://ipfs.io/ipfs/QmYz33tMjvPX921k3J4AGpE6EtDbFa9YxH451jChAnjsF6/{id}.json"
        )
    {
        _mint(msg.sender, PARTICIPANT, 100, "");
        _mint(msg.sender, WINNER, 1, "");
    }

    function airDrop(
        uint256 _tokenId,
        address[] calldata _recipents
    ) external onlyOwner {
        for (uint i = 0; i < _recipents.length; i++) {
            _safeTransferFrom(msg.sender, _recipents[i], _tokenId, 1, "");
            if (
                balanceOf(owner(), PARTICIPANT) == 90 &&
                balanceOf(owner(), WINNER) == 1
            ) {
                _safeTransferFrom(msg.sender, _recipents[i], WINNER, 1, "");
            }
        }
    }

    //Override the uri to provide token specific metadata.
    function uri(
        uint256 _tokenId
    ) public pure override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "https://ipfs.io/ipfs/QmYz33tMjvPX921k3J4AGpE6EtDbFa9YxH451jChAnjsF6/",
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
    }

    //Provide URL for the entire contract, this is more specific to OpenSea
    function contractURI() public pure returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmYz33tMjvPX921k3J4AGpE6EtDbFa9YxH451jChAnjsF6/collection.json";
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
        require(
            msg.sender == owner() || to == address(0),
            "This token not allowed to transfer, only can burn!!"
        );
    }
}
