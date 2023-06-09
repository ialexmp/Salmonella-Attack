import pytest
from brownie import Wei, reverts

def test_token_swap(accounts, MyToken, TokenSwap):
    initial_supply = 1000000
    deployer = accounts[0]
    token_seller = accounts[1]
    your_account = accounts[2]
    accounts[3].transfer(Wei("0.1 ether"),your_account.address)
    initial_balance = your_account.balance()
    # Deploy the token and transfer some to the token seller
    token = MyToken.deploy(initial_supply, {'from': deployer})
    token.transfer(token_seller, 10**18, {'from': deployer})

    # Deploy the TokenSwap contract
    token_swap = TokenSwap.deploy(token, {'from': deployer})

    # Approve the TokenSwap contract to spend tokens on behalf of the token seller
    token.approve(token_swap, 2*10**18, {'from': token_seller})

    # Store initial balances
    initial_balance_token_seller = token_seller.balance()
    initial_balance_eth_buyer = your_account.balance()


    # Lock tokens by the token seller
    token_swap.lockTokens(10**18, Wei("0.1 ether"), {'from': token_seller})

    # Your arbitrage here. Please do not change all the other code :) Not legal to make transfers from other addresses
    # You are just allowed to interact with the swap contract and the token contract that have the mint and burned function specified in previous exercies.

    # Check final balances
    assert your_account.balance()> initial_balance
