// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Hack} from "../src/Hack.sol";
import {Target} from "../src/Target.sol";

contract HackTest is Test {
    Hack public hack;
    Target public target;

    function setUp() public {
        target = new Target();
        hack = new Hack(address(target));
    }

    function test_pwn() public {
        hack.setup{value: 100 * 1e18}();
        hack.pwn{value: 10000 * 1e18}();
    }
}
