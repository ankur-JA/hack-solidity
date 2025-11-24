// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract TimeLock {

    error SendSomeETH();

    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;


    function deposit() external payable {
        if(msg.value <= 0) {
            revert SendSomeETH();
        }

        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;

    }

    function increaseLockTime(uint256 _time) external {
        unchecked {
            lockTime[msg.sender] += _time;
        }
        
    }

    function getLockTime() external view returns (uint256) {
        return lockTime[msg.sender];
    }

    function withdraw() external {
        if(balances[msg.sender] == 0) {
            revert();
        }
        if(lockTime[msg.sender] > block.timestamp) {
            revert();
        }

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Failed Transfer!");
    }
}