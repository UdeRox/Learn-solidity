// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Participants} from "../src/Participants.sol";

contract ParticipantsScript is Script {
    Participants public participants;

    //Deploy the Contract to the chain.
    function run() external returns (Participants) {
        vm.startBroadcast();
        participants = new Participants();
        vm.stopBroadcast();
        return participants;
    }
}
