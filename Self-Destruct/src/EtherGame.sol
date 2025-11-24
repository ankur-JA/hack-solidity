// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract EtherGame {
    uint256 public target = 7 ether;
    address public winner;

    function deposit() external payable {
        if(msg.value == 0) {
            revert();
        }

        uint256 balance = address(this).balance;
        require(balance <= target, "Game Over!");

        if(address(this).balance == target) {
            winner = msg.sender;
        }
    }

    function claimReward() external {
        require(msg.sender == winner, "Not Winner!");

        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Failed Transfer!");
    }
}
