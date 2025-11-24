// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EtherGame} from "../src/EtherGame.sol";
import {Attack} from "../src/Attack.sol";

contract CounterTest is Test {
    EtherGame public ethergame;
    Attack public attack;

    address public bob = address(0xAB);
    address public alice = address(0xA1);
    address public attackerEOA = address(0xA2B);

    function setUp() public {
        ethergame = new EtherGame();
        attack = new Attack(address(ethergame));


        vm.deal(bob, 5 ether);
        vm.deal(alice, 5 ether);
        vm.deal(attackerEOA, 10 ether);

    }

    function test_EtherGame() public {

        vm.startPrank(bob);
        ethergame.deposit{value: 1 ether}();
        vm.stopPrank();

        vm.startPrank(alice);
        ethergame.deposit{value: 1 ether}();
        vm.stopPrank();

        vm.startPrank(attackerEOA);
        attack.attack{value: 6 ether}();
        vm.stopPrank();

        assertEq(address(ethergame).balance, 8 ether);
        assertEq(ethergame.winner(), address(0));
    }
}
