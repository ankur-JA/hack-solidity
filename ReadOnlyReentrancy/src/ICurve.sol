// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ICurve {

    function get_virtual_price() external view returns (uint256);

    function add_liquidity(uint256[2] calldata _amounts, uint256 _min_mint_amount) external payable returns ();

    function remove_liquidity(uint256 _lp, uint256[2] calldata _min_amount) external returns (uint256[2] memory);

    function remove_liquidity_one_coin(uint256 _lp, int256 _i, uint256 _min_amount) external returns (uint256);
}