// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICurve {

    function get_virtual_price() external view returns (uint);

    function add_liquidity(uint256[2] calldata _amounts, uint256 _min_mint_amount) external payable returns (uint);

    function remove_liquidity(uint256 _lp, uint[2] calldata _min_amount) external returns (uint[2] memory);

    function remove_liquidity_one_coin(uint _lp, int128 _i, uint _min_amount) external returns (uint);
}