// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ParticipantsScript} from "../script/Participants.s.sol";
import {Participants} from "../src/Participants.sol";

contract ParticipantsTest is Test {
    ParticipantsScript participantsScript;
    Participants participants;
    address private participant = makeAddr("participant");
    uint256 private constant INITIAL_BALANCE = 100;
    address private deployer = makeAddr("deployer");

    function setUp() public {
        // vm.deal(deployer, INITIAL_BALANCE);
        // vm.prank(deployer);
        participantsScript = new ParticipantsScript();
        participants = participantsScript.run();
    }

    function testContractName() public view {
        string memory contractName = "Course Participant NFT";
        string memory deployedContractName = participants.name();

        assert(
            keccak256(abi.encodePacked(contractName)) ==
                keccak256(abi.encodePacked(deployedContractName))
        );
    }

    function testAirdrop() public {
        address mockAddress = makeAddr("Address1");
        address mockAddress2 = makeAddr("Address2");
        vm.prank(msg.sender);
        address[] memory mockAddresses = new address[](2);
        mockAddresses[0] = mockAddress;
        mockAddresses[1] = mockAddress2;
        participants.airDrop(0, mockAddresses);
        assertEq(participants.balanceOf(mockAddress, 0), 1);
    }

    function testAirDropByNotOwner() public {
        address mockAddress = makeAddr("Address1");
        address mockAddress2 = makeAddr("Address2");
        address notOwner = makeAddr("NotOwner");
        vm.prank(notOwner);
        address[] memory mockAddresses = new address[](2);
        mockAddresses[0] = mockAddress;
        mockAddresses[1] = mockAddress2;
        vm.expectRevert("Ownable: caller is not the owner");
        participants.airDrop(0, mockAddresses);
    }

    function testOwnerOfTheContract() public {
        assertEq(address(participants.owner()), msg.sender);
    }

    function testMintTokensToDeployer() public {
        assertEq(participants.balanceOf(msg.sender, 0), 100);
    }

    function testMetaUri() public view {
        string
            memory overrideUri = "https://ipfs.io/ipfs/QmYz33tMjvPX921k3J4AGpE6EtDbFa9YxH451jChAnjsF6/0.json";
        assert(
            keccak256(abi.encodePacked(overrideUri)) ==
                keccak256(abi.encodePacked(participants.uri(0)))
        );
    }

    function testTokenTransferByOwner() public {
        vm.prank(msg.sender);
        participants.safeTransferFrom(msg.sender, participant, 0, 1, "");
        assertEq(participants.balanceOf(msg.sender, 0), 99);
    }

    function testContractJsonURI() public view {
        string
            memory contractURI = "https://ipfs.io/ipfs/QmYz33tMjvPX921k3J4AGpE6EtDbFa9YxH451jChAnjsF6/collection.json";
        assert(
            keccak256(abi.encodePacked(contractURI)) ==
                keccak256(abi.encodePacked(participants.contractURI()))
        );
    }

    function testTokenTrandefByNotOwner() public {
        address notOwner = makeAddr("NotOwner");
        vm.prank(notOwner);
        vm.expectRevert("This token not allowed to transfer, only can burn!!");
        participants.safeTransferFrom(notOwner, participant, 0, 1, "");
    }
}
