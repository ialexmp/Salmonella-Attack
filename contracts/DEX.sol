pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";

contract DEX {
    
    address public owner;
    uint256 public price;
    IERC20 public token;
    uint256 public precisionPoints;
    
    event Bought(address buyer, uint256 amount);
    event Sold(address seller,  uint256 amount);
    
    constructor(IERC20 _tokenAddress, uint256 _price, uint256 pps) {
        owner=msg.sender;
        token=_tokenAddress;
        price=_price;
        precisionPoints=pps;
    }

    /**
    * @dev Deposits ETH into the contract and transfers tokens to the contract
    */
    function deposit() payable public {
        // Require the sender to have enough tokens to cover the deposit
        require(token.balanceOf(msg.sender)>=div(msg.value*price,10**precisionPoints) );
        // Transfer tokens from the sender to the contract
        token.transferFrom(msg.sender,address(this),div(msg.value*price,10**precisionPoints));

    }

    /**
    * @dev Withdraws ETH from the contract and transfers tokens to the owner
    */
    function withdraw(uint256 ethAmount) public {
        // Require the caller to be the contract owner
        require(msg.sender==owner);
        // Require the contract to have enough ETH balance for withdrawal
        require(ethAmount<=address(this).balance);
        // Transfer ETH to the contract owner
        payable(msg.sender).transfer(ethAmount);
        // Transfer tokens from the contract to the contract owner
        token.transfer(msg.sender,div(ethAmount*price,10**precisionPoints));
    }

    /**
    * @dev transfers tokens to the owner
    */
    function buyToken() payable public  {
        // Require the contract to have enough token balance to cover the purchase
        require(token.balanceOf(address(this))>=div(msg.value*price,10**precisionPoints), "Token balance overflow");
        // Transfer tokens from the contract to the buyer
        token.transfer(msg.sender,div(msg.value*price,10**precisionPoints));
        emit Bought(msg.sender,div(msg.value*price,10**precisionPoints));
    }

    /**
    * @dev Allows users to sell tokens 
    */
    function sellToken(uint256 amount) public payable {
        // Require the seller to have enough tokens for sale
        require(token.balanceOf(msg.sender)>=amount, "You got trapped :) ");
        // Calculate the amount of tokens to buy based on the selling amount and price
       	uint256 tokensToBuy = div(amount, price) * 10**precisionPoints; 
        // Require the contract to have enough ETH balance for the purchase
        require(address(this).balance>=tokensToBuy);
        //payable(msg.sender).transfer(tokensToBuy);
        // Transfer tokens from the seller to the contract
        token.transferFrom(msg.sender, address(this), amount);
        emit Sold(msg.sender, amount);

    }
    /**
    * @dev Internal function to perform integer division safely
    * as we are dealing with unsigned integers with no decimal places, division needs to be done carefully
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require(b > 0, "doesn't divide");
            return a / b;
        }
    }
}
