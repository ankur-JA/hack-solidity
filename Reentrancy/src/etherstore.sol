// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ReentrancyGuard} from "./ReeentrancyGuard.sol";

contract EtherStore is ReentrancyGuard {

    error InsufficientFund();

    mapping (address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }
 
    function withdraw(uint256 _amount) external noReentrancy {
        if(balances[msg.sender] < _amount) {
            revert InsufficientFund();
        }

        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Failed Transfer!");
        
        unchecked {
            balances[msg.sender] -= _amount;
        }
        
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}

