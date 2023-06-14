import pytest
from brownie import DEX, SalmonellaAttackToken, accounts

def test_transfer_properly():
    # Deploy contracts
    owner = accounts[0]
    victim = accounts[1]
    attacker = accounts[2]
    initial_supply = 1000000
    token = SalmonellaAttackToken.deploy(initial_supply, {'from': owner})
    dex = DEX.deploy(token.address, 1, 18, token.address, {'from': owner})

    # Victim transfers tokens to the DEX contract
    token.transfer(dex.address, 1000, {'from': victim})
    print("Victim balance before buy: ", token.balanceOf(victim))
    print("DEX balance before buy: ", token.balanceOf(dex.address))
    print("Attacker balance before buy: ", token.balanceOf(attacker))

    # Attacker buys tokens from the DEX contract
    dex.buyToken({'from': attacker, 'value': 1000})
    print("Victim balance after buy: ", token.balanceOf(victim))
    print("DEX balance after buy: ", token.balanceOf(dex.address))
    print("Attacker balance after buy: ", token.balanceOf(attacker))

    # Check balances
    assert token.balanceOf(victim) == initial_supply - 1000
    assert token.balanceOf(dex.address) == 1000
    assert token.balanceOf(attacker) == 100

def test_transfer_trapped():
    # Deploy contracts
    owner = accounts[0]
    victim = accounts[1]
    attacker = accounts[2]
    initial_supply = 1000000
    token = SalmonellaAttackToken.deploy(initial_supply, {'from': owner})
    dex = DEX.deploy(token.address, 1, 18, token.address, {'from': owner})

    # Victim transfers tokens to the DEX contract
    token.transfer(dex.address, 1000, {'from': victim})
    print("Victim balance before buy: ", token.balanceOf(victim))
    print("DEX balance before buy: ", token.balanceOf(dex.address))
    print("Attacker balance before buy: ", token.balanceOf(attacker))

    # Attacker buys tokens from the DEX contract
    dex.buyToken({'from': attacker, 'value': 1000})
    print("Victim balance after buy: ", token.balanceOf(victim))
    print("DEX balance after buy: ", token.balanceOf(dex.address))
    print("Attacker balance after buy: ", token.balanceOf(attacker))

    # Check balances
    assert token.balanceOf(victim) == initial_supply - 100
    assert token.balanceOf(dex.address) == 100
    assert token.balanceOf(attacker) == 10

def main():
    test_transfer_properly()
    test_transfer_trapped()
