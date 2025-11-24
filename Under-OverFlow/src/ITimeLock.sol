// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface ITimeLock {
    function deposit() external payable;

    function increaseLockTime(uint _time) external;

    function getLockTime() external view returns (uint256);

    function withdraw() external;
}