// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingOfGame {
    address public king;
    uint256 public balance;


    constructor() {
        king = msg.sender;
        balance = 0;
    }

    function ClaimThrone() external payable {
        require(msg.value > balance, "You don't have enough ETH To become KING!");

        (bool success, ) = payable(king).call{value: balance}("");
        require(success, "Failed Transfer!");

        king = msg.sender;
        balance = msg.value;
    }

}