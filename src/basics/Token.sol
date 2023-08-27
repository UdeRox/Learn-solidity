// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
/**
 * @title 
 * @author @udeRox 
 * @notice 
 * To get the structure of the storage in foundry, run 
 *  forge inspect Token storage --pretty, this shows slot indexes for the attributes in the contract.
 * 
 */
contract Token {
    address immutable i_owener;
    uint number;
    mapping(address => uint256) public s_balanceOf;
    uint256 public s_totcalSupply;

    constructor(uint256 _totalSupply) {
        i_owener = msg.sender;
        s_totcalSupply = _totalSupply;
    }

    function mint(address _reciver, uint256 _amount) external {
        require(i_owener == msg.sender, "Token::mint: invalid owner");
        s_balanceOf[_reciver] += _amount;
    }
}
