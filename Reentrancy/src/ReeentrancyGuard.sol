// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ReentrancyGuard {
    bool public locked;

    modifier noReentrancy() {
        require(!locked, "No re-etrancy");
        locked = true;
        _;
        locked = false;
    }
}