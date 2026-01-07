// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Target {

    function isContract(address _account) public pure returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(_account);
        }

        return size > 0;
    }
    
    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "No contract allowed!");

        pwned = true;
    }
}
