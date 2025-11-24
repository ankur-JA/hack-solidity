// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TimeLock} from "../src/TimeLock.sol";
import {Attack} from "../src/Attack.sol";

contract TimeLockTest is Test {
    TimeLock public timelock;
    Attack public attack;

    address attackerEOA = address(0xAB12);

    function setUp() public {
        timelock = new TimeLock();
        attack = new Attack(address(timelock));

        vm.deal(attackerEOA, 5 ether);
    }

    function test_TimeLock() public {
        vm.startPrank(attackerEOA);
        attack.attack{value: 2 ether}();
        vm.stopPrank();

        assertEq(address(attack).balance, 2 ether);
    }
}
