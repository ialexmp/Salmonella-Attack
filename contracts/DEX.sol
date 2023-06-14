pragma solidity ^0.8.0;

import "./SalmonellaAttackToken.sol";

contract DEX {
    SalmonellaAttackToken public token;
    
    constructor(address tokenAddress) {
        token = SalmonellaAttackToken(tokenAddress);
    }
    
    function buyTokens(uint256 amount) external payable {
        require(msg.value > 0, "Invalid amount");
        
        uint256 tokenAmount = amount * 10**uint256(token.decimals());
        
        // Transfer Ether from the buyer to the DEX contract
        (bool success, ) = address(this).call{value: msg.value}("");
        require(success, "Ether transfer failed");
        
        // Transfer tokens from the DEX contract to the buyer
        token.transfer(msg.sender, tokenAmount);
    }
    
    function sellTokens(uint256 amount) external {
        require(amount > 0, "Invalid amount");
        
        uint256 tokenAmount = amount * 10**uint256(token.decimals());
        
        // Transfer tokens from the seller to the DEX contract
        token.transferFrom(msg.sender, address(this), tokenAmount);
        
        // Transfer Ether from the DEX contract to the seller
        (bool success, ) = msg.sender.call{value: tokenAmount}("");
        require(success, "Ether transfer failed");
    }
}
