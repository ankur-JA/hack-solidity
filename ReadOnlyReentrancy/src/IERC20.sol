pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function transfer(address _to, uint256 _amount) external returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);

    function approve(address _spender, uint256 _value) external returns (bool success);

    function allowance(address _owner, address _spender) external view returns (bool success);

    function balanceOf() external view returns (uint256);


    event Transfer(address indexed _to, uint256 _amount);

    event Approval(address indexed _spender, uint256 _amount);
}