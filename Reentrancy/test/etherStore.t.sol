// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EtherStore} from "../src/etherstore.sol";
import {Attack} from "../src/attack.sol";

contract EtherStoreTest is Test {
    EtherStore etherstore;
    Attack attacker;


    address attackEOA = address(0xBEEF);

    function setUp() public {
        etherstore = new EtherStore();
        attacker = new Attack(address(etherstore));

        vm.deal(attackEOA, 10 ether);
    }

    function test_Attack() public {
        etherstore.deposit{value: 5 ether}();

        vm.startPrank(attackEOA);
        attacker.attack{value: 1 ether}();
        vm.stopPrank();

        emit log_named_uint("AttackerEOA", attackEOA.balance);
        emit log_named_uint("EtherStore balance", etherstore.getBalance());
        emit log_named_uint("Attacker balance", attacker.getBalance());

        
        assertEq(etherstore.getBalance(), 0 ether, "Should withdraw all ETH");
        assertEq(attacker.getBalance(), 6 ether, "You hacked them!");

    }


}

// Result 
// attackEOA = 4 ether
// EtherStore = 0 ether
// attack = 6 ether
