// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/console.sol";

address constant STETH_POOL = 0xDC24316b9AE028F1497c275EB9192a3Ea0f67022;
address constant LP = 0x06325440D014e39736583c165C2963BA99fAf14E;

import {ICurve} from "./ICurve.sol";
import {IERC20} from "./IERC20.sol";


contract Target {
    ICurve private constant pool = ICurve(STETH_POOL);
    IERC20 private constant token = IERC20(LP);

    mapping (address => uint) public balanceOf;

    function stake(uint _value) external {
        token.transferFrom(msg.sender, address(this), _value);
        balanceOf[msg.sender] += _value;
    }

    function unStake(uint _value) external {
        token.transfer(msg.sender, _value);
    }

    function getReward() external returns (uint) {
        uint reward = (balanceOf[msg.sender] * pool.get_virtual_price()) / 1e18;

        return reward;
    }
}