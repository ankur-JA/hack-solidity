// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ITarget {
    function stake(uint _value) external;

    function unStake(uint _value) external;

    function getReward() external returns (uint);
}