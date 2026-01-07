// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ITarget {
    function isContract(address _account) external pure returns (bool);

    function protected() external;
}