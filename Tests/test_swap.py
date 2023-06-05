import pytest
from brownie import Wei, reverts

def test_token_swap(accounts, MyToken, TokenSwap):
    initial_supply = 1000000
    deployer = accounts[0]
    token_seller = accounts[1]
    eth_buyer = accounts[2]

    # Deploy the token and transfer some to the token seller
    token = MyToken.deploy(initial_supply, {'from': deployer})
    token.transfer(token_seller, 10**18, {'from': deployer})

    # Deploy the TokenSwap contract
    token_swap = TokenSwap.deploy(token, {'from': deployer})

    # Approve the TokenSwap contract to spend tokens on behalf of the token seller
    token.approve(token_swap, 10**18, {'from': token_seller})

    # Store initial balances
    initial_balance_token_seller = token_seller.balance()
    initial_balance_eth_buyer = eth_buyer.balance()

    # Lock tokens by the token seller
    token_swap.lockTokens(10**18, Wei("1 ether"), {'from': token_seller})

    # The token seller should not be able to unlock tokens before the lock time expires
    with reverts("Tokens still locked"):
        token_swap.unlockTokens({'from': token_seller})

    # The ETH buyer sends ETH and performs the swap
    token_swap.performSwap(token_seller, {'from': eth_buyer, 'value': Wei("1 ether")})

    # Check final balances
    assert token.balanceOf(token_seller) == 0
    assert token.balanceOf(eth_buyer) == 10**18
    assert eth_buyer.balance() == initial_balance_eth_buyer - Wei("1 ether")
    assert token_seller.balance() == initial_balance_token_seller + Wei("1 ether")
