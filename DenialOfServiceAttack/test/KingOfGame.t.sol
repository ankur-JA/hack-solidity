// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {KingOfGame} from "../src/KingOfGame.sol";
import {DOSAttack} from "../src/DOSAttack.sol";
import {IKingOfGame} from "../src/IKingOfGame.sol";

contract CounterTest is Test {
    KingOfGame public kingOfGame;
    DOSAttack public dosAttack;
    IKingOfGame public ikingOfGame;

    function setUp() public {
        kingOfGame = new KingOfGame();
        dosAttack = new DOSAttack(address(kingOfGame));
        ikingOfGame = new IKingOfGame();
    }

    function test_KingOfGame() public {

    }
}   ₹1
