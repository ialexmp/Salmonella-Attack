// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SalmonellaAttackToken.sol";

contract DEX {
    SalmonellaAttackToken private token;
    address private owner;

    constructor(address tokenAddress) {
        token = SalmonellaAttackToken(tokenAddress);
        owner = msg.sender;
    }

    function buyTokens(uint256 amount) external payable {
        uint256 tokenAmount = amount * 10**token.decimals();
        require(msg.value == tokenAmount, "Incorrect ETH value");

        token.transferFrom(owner, msg.sender, tokenAmount);
    }

    function sellTokens(uint256 amount) external {
        uint256 tokenAmount = amount * 10**token.decimals();

        token.transferFrom(msg.sender, owner, tokenAmount);
        payable(msg.sender).transfer(tokenAmount);
    }
}
